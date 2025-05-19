# local-exe:
    resource "null_resource" "invoke_openai" {
      provisioner "local-exec" {
        command = <<EOT
          curl -s -X POST "$AZURE_OPENAI_ENDPOINT/openai/deployments/$AZURE_OPENAI_DEPLOYMENT_NAME/chat/completions?api-version=2023-03-15-preview" \
            -H "Content-Type: application/json" \
            -H "api-key: $AZURE_OPENAI_API_KEY" \
            -d '{
              "messages": [{"role": "user", "content": "Hello, Azure OpenAI!"}],
              "temperature": 0.7
            }'
        EOT
        environment = {
          AZURE_OPENAI_ENDPOINT        = var.azure_openai_endpoint
          AZURE_OPENAI_API_KEY         = var.azure_openai_api_key
          AZURE_OPENAI_DEPLOYMENT_NAME = var.azure_openai_deployment_name
        }
      }
    }
