# WebCrawler Napista

## English

This is a Ruby program that allows you to search for information about cars in a specific city. With it, you can obtain data such as brand, model, year of manufacture, price, and images of the available vehicles.

### How to Use

1. Clone this repository to your local machine.
2. Make sure you have Ruby installed on your system.
3. Install the dependencies by running `bundle install` in the terminal.
4. Execute the program by typing `ruby webcrawler.rb` in the terminal.
5. Follow the instructions to enter the name of the desired city and wait for the results.

### Logic of the Program

1. **Search for Cars in a City**: The program prompts the user to enter the name of the desired city and constructs a specific URL for the Napista website based on this input.
2. **Navigation and Data Extraction**: Using the Mechanize library, the program accesses the corresponding page for the constructed URL and extracts information about the available cars in that city.
3. **Organization and Data Saving**: The extracted data is organized into a Ruby dictionary structure and saved in JSON files. Each JSON file contains information about several cars found in the specified city.
4. **Folder and Image Management**: The program creates and organizes folders to store images of the cars. The images are saved with descriptive names based on the brand, model, and year of manufacture of the vehicle for easy identification.
5. **Iteration and Continuation of the Search**: The program iterates over subsequent pages of the Napista website, ensuring that all available information is collected.
6. **User Interaction**: The program interacts with the user through messages in the terminal, allowing them to track the progress of the search and make decisions about saving the images.

### Running on Windows

If you're using Windows, you can follow these steps to run the program:

1. Install Ruby: Download and install Ruby from the [official website](https://www.ruby-lang.org/en/downloads/).
2. Clone this repository: Open Command Prompt (cmd) and navigate to the directory where you want to clone the repository. Then, run the command `git clone https://github.com/yourusername/yourrepository.git`.
3. Install dependencies: Navigate to the cloned repository directory using Command Prompt and run `bundle install` to install the required gems.
4. Execute the program: In the same directory, run `ruby webcrawler.rb` to start the program.
5. Follow the on-screen instructions to enter the name of the desired city and wait for the results.

## Português

Este é um programa desenvolvido em Ruby que permite buscar informações sobre carros em uma determinada cidade. Com ele, você pode obter dados como marca, modelo, ano de fabricação, preço e imagens dos veículos disponíveis.

### Como Usar

1. Clone este repositório em sua máquina local.
2. Certifique-se de ter o Ruby instalado em seu sistema.
3. Instale as dependências executando `bundle install` no terminal.
4. Execute o programa digitando `ruby webcrawler.rb` no terminal.
5. Siga as instruções para inserir o nome da cidade desejada e aguarde os resultados.

### Lógica do Programa

1. **Busca por Carros em uma Cidade**: O programa solicita ao usuário o nome da cidade desejada e constrói uma URL específica para o site Napista com base nessa entrada.
2. **Navegação e Extração de Dados**: Usando a biblioteca Mechanize, o programa acessa a página correspondente à URL construída e extrai informações sobre os carros disponíveis naquela cidade.
3. **Organização e Salvamento de Dados**: Os dados extraídos são organizados em uma estrutura de dicionário Ruby e salvos em arquivos JSON. Cada arquivo JSON contém informações sobre vários carros encontrados na cidade especificada.
4. **Gerenciamento de Pastas e Imagens**: O programa cria e organiza pastas para armazenar as imagens dos carros. As imagens são salvas com nomes descritivos baseados na marca, modelo e ano de fabricação do veículo para facilitar a identificação.
5. **Iteração e Continuidade da Busca**: O programa itera sobre as páginas subsequentes do site Napista, garantindo que todas as informações disponíveis sejam coletadas.
6. **Interação com o Usuário**: O programa interage com o usuário por meio de mensagens no terminal, permitindo que ele acompanhe o progresso da busca e tome decisões sobre o salvamento das imagens.

### Executando no Windows

Se você estiver usando o Windows, pode seguir estas etapas para executar o programa:

1. Instalar o Ruby: Baixe e instale o Ruby no [site oficial](https://www.ruby-lang.org/en/downloads/).
2. Clonar este repositório: Abra o Prompt de Comando (cmd) e navegue até o diretório onde deseja clonar o repositório. Em seguida, execute o comando `git clone https://github.com/seunome/usuariorepositorio.git`.
3. Instalar dependências: Navegue até o diretório do repositório clonado usando o Prompt de Comando e execute `bundle install` para instalar as gems necessárias.
4. Executar o programa: No mesmo diretório, execute `ruby webcrawler.rb` para iniciar o programa.
5. Siga as instruções na tela para inserir o nome da cidade desejada e aguarde os resultados.
