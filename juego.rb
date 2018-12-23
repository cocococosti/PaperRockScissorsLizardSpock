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
		para jugador1
		para jugador2
		para puntos
		para rondas
	end
end
