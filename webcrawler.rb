require 'mechanize'
require 'json'
require 'fileutils'

# Mensagem de boas-vindas ao iniciar o programa
def welcome_message
  puts "__________>>> Bem-vindo ao WebCrawler! <<<__________"
  puts "\n\n[+] Este programa faz a varredura no site http\\:napista.com utilizando o Mechanize do Ruby."
  puts "\n[-] Para encerrar a aplicação, digite 'exit'."
  puts "\n\n ------------------>>> Iniciando WebCrawler <<<------------------\n\n"
end

# Cria a pasta da cidade onde serão salvos os resultados da pesquisa
def create_city_folder(city_name)
  city_folder = File.join(__dir__, "results", city_name.downcase.tr(' ', '_'))
  unless File.directory?(city_folder)
    begin
      FileUtils.mkdir_p(city_folder)
    rescue SystemCallError => e
      puts "Erro ao criar a pasta da cidade: #{e.message}"
      return nil
    end
  end
  city_folder
end

# Cria subpastas para imagens e arquivos JSON dentro da pasta da cidade
def create_subfolders(city_folder)
  return [], [] unless city_folder

  images_folder = File.join(city_folder, "photocars")
  json_folder = File.join(city_folder, "json")

  [images_folder, json_folder]
end


# Salva uma imagem em uma pasta específica
def save_image(image_url, image_name, folder_path)
  agent = Mechanize.new
  agent.get(image_url).save(File.join(folder_path, image_name))
rescue StandardError => e
  puts "Erro ao salvar imagem: #{e.message}"
end

# Salva dados dos veículos em um arquivo JSON
def save_vehicle_data_to_json(vehicles, json_folder, city_name)
  return unless json_folder

  json_file_path = File.join(json_folder, "#{city_name.downcase.tr(' ', '_')}_car_data.json")

  if vehicles.any?
    json_data = JSON.pretty_generate(vehicles)
    puts "___>>> Total de carros encontrados para a cidade #{city_name.capitalize}: #{vehicles.size} <<<___\n\n"
    puts "-------------------------Salvando JSON-------------------------\n\n"
    FileUtils.mkdir_p(json_folder) unless File.directory?(json_folder)
    File.open(json_file_path, "w") { |file| file.puts(json_data) }
    puts "___>>> Dados dos carros salvos no arquivo JSON em: #{json_file_path} <<<___\n\n"
  else
    puts "\n[-] Nenhum veículo encontrado para a cidade >>> #{city_name} <<<___\n\n"
    FileUtils.remove_dir(json_folder) if File.directory?(json_folder)
  end
end

# Pergunta ao usuário se deseja salvar as imagens dos veículos e se deseja realizar uma nova pesquisa
def ask_to_save_images(city_folder, vehicles)
  if vehicles.empty?
    print "[+] Deseja realizar uma nova pesquisa? (s/n): "
    nova_pesquisa = gets.chomp.downcase
    return nova_pesquisa == 's'
  end

  print "[+] Deseja salvar as imagens dos veículos pesquisados? (s/n): "
  salvar_imagens = gets.chomp.downcase

  if salvar_imagens == 's'
    puts " ------------------>>> Salvando imagens ... aguarde ! <<<------------------\n\n"
    images_folder = File.join(city_folder, "photocars")
    FileUtils.mkdir_p(images_folder) unless File.directory?(images_folder)
    save_vehicle_images(vehicles, images_folder)
  end

  print "[+] Deseja realizar uma nova pesquisa? (s/n): "
  nova_pesquisa = gets.chomp.downcase
  nova_pesquisa == 's'
end

# Salva as imagens dos veículos em uma pasta específica
def save_vehicle_images(vehicles, images_folder)
  vehicles.each do |vehicle|
    marca_modelo_ano = "#{vehicle[:marca]}_#{vehicle[:modelo]}_#{vehicle[:ano_fabricacao]}"
    image_name = "#{marca_modelo_ano}.jpg"
    FileUtils.mkdir_p(images_folder) unless File.directory?(images_folder)
    save_image(vehicle[:local_path], image_name, images_folder)
  end
  puts "As imagens foram salvas em : #{images_folder}\n\n"
  puts "\n\n-------------------------WebCrawler Concluído------------------------- \n\n"
end

# Função principal do programa
def main
  welcome_message

  loop do
    agent = Mechanize.new

    print "\n[+] Digite o nome da cidade que deseja filtrar os veículos : "
    input = gets.chomp

    break if input.downcase == 'exit'
    puts "\n\n-------------------------Iniciando a varredura------------------------- \n\n"
    city_url = input.downcase.tr(' ', '-')

    base_url = "https://napista.com.br/busca/carro-em-#{city_url}/"
    url = base_url

    city_folder = create_city_folder(input)
    next unless city_folder 

    subfolders = create_subfolders(city_folder)
    images_folder, json_folder = subfolders

    vehicles = []

    begin
      loop do
        page = agent.get(url)
        vehicle_list = page.search('li.sc-5b587bbb-0.lepzaa')

        break if vehicle_list.empty?

        vehicle_list.each do |vehicle|
          title_element = vehicle.at('h2')
          next if title_element.nil? 
          title = title_element.attr('title')
          title_parts = title.split(' ')
          marca = title_parts.first 
          model = title_parts[1..].join(' ') 
          image_url = vehicle.at('img')&.attr('src')
          price_element = vehicle.at('.sc-e166232d-0.feFCDP')
          price = price_element.text.strip if price_element 
          year_element = vehicle.at('.sc-e166232d-0.bDVNbb')
          year = year_element.text.strip.to_i if year_element

          next unless title && marca && model && price && year && image_url

          # Calcula o ano do modelo (ano de fabricação + 1)
          model_year = year + 1
          #model_year = (year.to_i + 1).to_s
          vehicle_data = {
            modelo: model,
            marca:  marca,
            valor: price,
            ano_fabricacao: year,
            ano_modelo: model_year,
            local_path: image_url
          }
 
          vehicles << vehicle_data
        end

        break if page.search('.next.disabled').any?
        next_page_number = (url.match(/page=(\d+)/) || [])[1].to_i + 1 
        url = base_url + "?page=#{next_page_number}"
      end
    rescue Mechanize::ResponseCodeError => e
      puts "Erro ao acessar a página: #{e.message}"
      next
    rescue StandardError => e
      puts "Erro inesperado: #{e.message}"
      next
    end
    
    save_vehicle_data_to_json(vehicles, json_folder, input)
    break unless ask_to_save_images(city_folder, vehicles)
  end
end

main
