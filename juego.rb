class Jugada

	attr_reader :jugada

	def initialize(mano)
		@jugada = mano
	end

	def to_s
		s = @jugada
		s
	end

end

class Piedra < Jugada

	def puntos(j)
		if j == "tijeras"
			resultado = [1,0]
		elsif j == "papel" 
			resultado = [0,1]
		elsif j == "spock"
			resultado = [0,1]
		elsif j == "lagarto"
			resultado = [1,0]
		elsif j == "piedra"
			resultado = [0,0]
		else
			raise "Movimiento invalido"
		end
		resultado
	end
end

pi = Piedra.new "piedra"
puts pi
puts pi.puntos("tijeras").to_s


titulo = "Piedra Papel Tijeras Lagarto Spock"

# Ventana principal
Shoes.app(width: 1000, height:572, title:titulo) do

	# Stack principal
	inicio = stack width: 1000, height:572 do

		# Estrategias a usar por cada usuario
		estrategia1 = ""
		estrategia2 = ""

		# Fondo de la ventana principal
		background "fondo.jpg"

		# Al hacer click en el boton inicio limpiamos la ventana
		# y agregamos nuevos elementos
		@botonInicio = button "Empezar"
		@botonInicio.click do

			inicio.clear
			background "fondo.jpg"
			
			inicio.append do

				# Agregamos stack de botones con las opciones de estrategias
				stack margin: 300 do 

					para "Jugador 1"
					para "Escoge una estrategia de juego"

					button "Manual" do
						estrategia1 = "manual"	
					end

					flow  do
						button "Uniforme" do
							estrategia1 = "uniforme"
						end

						button "Sesgada" do
							estrategia1 = "sesgada"	
						end
					end

					flow do
						button "Copiar" do
							estrategia1 = "copiar"	
						end

						button "Pensar" do
							estrategia1 = "pensar"	
						end

					end

					button "Siguiente" do

						if estrategia1 != ""

							inicio.clear
							background "fondo.jpg"

							inicio.append do
								stack margin: 300 do

									para "Jugador 2"
									para "Escoge una estrategia de juego"

									button "Manual" do
										estrategia2 = "manual"
									end

									flow  do
										button "Uniforme" do
											estrategia2 = "uniforme"
										end

										button "Sesgada" do
											estrategia2 = "sesgada"	
										end
									end

									flow do
										button "Copiar" do
											estrategia2 = "copiar"	
										end

										button "Pensar" do
											estrategia2 = "pensar"
										end
									end

									button "Siguiente" do

										if estrategia2 != ""
											inicio.clear
											background "fondo.jpg"
											@puntos = ""
											@rondas = ""
											inicio.append do
										      	flow margin: 300 do
										      		stack do
														para "Rondas"
														@r = edit_line
										      		end
										      		stack do
										 	     		para "Puntos"
										 	     		@pu = edit_line
										        	end
										        	button "OK" do
										       			@rondas = @r.text
										    	   		@puntos = @pu.text
										        		
										        		if @puntos != ""
										        			

											        		inicio.clear
											        		jugar(inicio, estrategia1, estrategia2, @puntos, @rondas)
											        		
											        	end
										        	end
										      	end
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end
end

def jugar inicio, jugador1, jugador2, puntos, rondas
	inicio.append do
		background "versus.jpg"

		partida = flow do 
			col1 = flow :width => '50%', :top => '500', :left => '15' do 
				button "Piedra" do
					inicio.append do
						stack :top => '200', :left => '40', :width => '200', :height => '300' do
							piedra = image "piedra2.png"
						end
					end
				end

				button "Papel" do
					inicio.append do
						stack :top => '200', :left => '40', :width => '200', :height => '300' do
							papel = image "papel2.png"
						end
					end
				end

				button "Tijeras" do
					inicio.append do
						stack :top => '200', :left => '40', :width => '200', :height => '300' do
							tijeras = image "tijeras2.png"
						end
					end
				end

				button "Lagarto" do
					inicio.append do
						stack :top => '200', :left => '40', :width => '200', :height => '300' do
							lagarto = image "lizard2.png"
						end
					end
				end

				button "Spock" do
					inicio.append do
						stack :top => '200', :left => '40', :width => '200', :height => '300' do
							spock = image "spock2.png"
						end
					end
				end

			end

			flow :width => '50%', :top => '500', :left => '530' do 
				button "Piedra" do
					inicio.append do
						stack :top => '200', :left => '580', :width => '200', :height => '300' do
							piedra = image "piedra.png"
						end
					end
				end

				button "Papel" do
					inicio.append do
						stack :top => '200', :left => '580', :width => '200', :height => '300' do
							piedra = image "papel.png"
						end
					end
				end

				button "Tijeras" do
					inicio.append do
						stack :top => '200', :left => '580', :width => '200', :height => '300' do
							piedra = image "tijeras.png"
						end
					end
				end

				button "Lagarto" do
					inicio.append do
						stack :top => '200', :left => '580', :width => '200', :height => '300' do
							piedra = image "lizard.png"
						end
					end
				end

				button "Spock" do
					inicio.append do
						stack :top => '200', :left => '580', :width => '200', :height => '300' do
							piedra = image "spock.png"
						end
					end
				end
			end
		end
	end
end
