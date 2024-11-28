import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.input.TextFieldValue
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.compose.ui.window.Window
import androidx.compose.ui.window.WindowState
import androidx.compose.ui.window.application
import androidx.compose.ui.window.rememberWindowState
import io.github.cdimascio.dotenv.dotenv
import kotlinx.coroutines.launch

@OptIn(ExperimentalMaterial3Api::class)
fun main() = application {
    System.setProperty("skiko.renderApi", "SOFTWARE")
    
    val dotenv = dotenv {
        directory = "."
        ignoreIfMissing = true
    }
    
    val apiKey = dotenv["OPENAI_API_KEY"] ?: ""
    if (apiKey.isBlank()) {
        error("OpenAI API key not found. Please set it in the .env file")
    }
    
    val viewModel = remember { ChatViewModel(apiKey) }
    val scope = rememberCoroutineScope()
    
    Window(
        onCloseRequest = ::exitApplication,
        title = "ChatBot - Compose Desktop",
        state = rememberWindowState(width = 800.dp, height = 800.dp)
    ) {
        val messages by viewModel.messages.collectAsState()
        val isLoading by viewModel.isLoading.collectAsState()
        var inputText by remember { mutableStateOf(TextFieldValue()) }

        MaterialTheme {
            Column(
                modifier = Modifier
                    .fillMaxSize()
                    .padding(16.dp)
            ) {
                // Messages list
                LazyColumn(
                    modifier = Modifier
                        .weight(1f)
                        .fillMaxWidth()
                ) {
                    items(messages) { message ->
                        ChatBubble(message)
                        Spacer(modifier = Modifier.height(8.dp))
                    }
                }

                // Loading indicator
                if (isLoading) {
                    LinearProgressIndicator(
                        modifier = Modifier.fillMaxWidth()
                    )
                }

                // Input field and send button
                Row(
                    modifier = Modifier.fillMaxWidth(),
                    horizontalArrangement = Arrangement.spacedBy(8.dp)
                ) {
                    TextField(
                        value = inputText,
                        onValueChange = { inputText = it },
                        modifier = Modifier.weight(1f),
                        placeholder = { Text("Type a message...") },
                        enabled = !isLoading
                    )
                    Button(
                        onClick = {
                            scope.launch {
                                viewModel.sendMessage(inputText.text)
                                inputText = TextFieldValue("")
                            }
                        },
                        enabled = !isLoading && inputText.text.isNotBlank()
                    ) {
                        Text("Send")
                    }
                }
            }
        }
    }
}

@Composable
fun ChatBubble(message: ChatMessage) {
    Box(
        modifier = Modifier.fillMaxWidth(),
        contentAlignment = if (message.isUser) Alignment.CenterEnd else Alignment.CenterStart
    ) {
        Surface(
            shape = RoundedCornerShape(8.dp),
            color = if (message.isUser) MaterialTheme.colorScheme.primary else MaterialTheme.colorScheme.secondary,
            modifier = Modifier.widthIn(max = 300.dp)
        ) {
            Text(
                text = message.content,
                modifier = Modifier.padding(8.dp),
                color = Color.White
            )
        }
    }
}
