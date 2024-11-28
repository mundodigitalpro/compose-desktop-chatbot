import com.aallam.openai.api.chat.ChatCompletionRequest
import com.aallam.openai.api.chat.ChatMessage as OpenAIChatMessage
import com.aallam.openai.api.chat.ChatRole
import com.aallam.openai.api.model.ModelId
import com.aallam.openai.client.OpenAI
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow

class ChatViewModel(private val apiKey: String) {
    private val openAI = OpenAI(apiKey)
    private val _messages = MutableStateFlow<List<ChatMessage>>(emptyList())
    val messages: StateFlow<List<ChatMessage>> = _messages.asStateFlow()

    private val _isLoading = MutableStateFlow(false)
    val isLoading: StateFlow<Boolean> = _isLoading.asStateFlow()

    suspend fun sendMessage(content: String) {
        if (content.isBlank()) return

        // Add user message
        val userMessage = ChatMessage(content = content, isUser = true)
        _messages.value = _messages.value + userMessage

        _isLoading.value = true
        try {
            // Convert chat history to OpenAI format
            val chatMessages = _messages.value.map { message ->
                OpenAIChatMessage(
                    role = if (message.isUser) ChatRole.User else ChatRole.Assistant,
                    content = message.content
                )
            }

            // Create chat completion request
            val completionRequest = ChatCompletionRequest(
                model = ModelId("gpt-3.5-turbo"),
                messages = chatMessages
            )

            // Get response from OpenAI
            val completion = openAI.chatCompletion(completionRequest)
            val responseContent = completion.choices.first().message.content ?: "No response received"

            // Add assistant message
            val assistantMessage = ChatMessage(content = responseContent, isUser = false)
            _messages.value = _messages.value + assistantMessage
        } catch (e: Exception) {
            val errorMessage = ChatMessage(
                content = "Error: ${e.message ?: "Unknown error occurred"}",
                isUser = false
            )
            _messages.value = _messages.value + errorMessage
        } finally {
            _isLoading.value = false
        }
    }
}
