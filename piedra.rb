# Fuente: https://www.rubyguides.com/2016/05/weighted-random-numbers/
def random_weighted(weighted)
	max    = sum_of_weights(weighted)
	target = rand(1..max)
	weighted.each do |item, weight|
		return item if target <= weight
		target -= weight
	end
end

def sum_of_weights(weighted)

	weighted.inject(0) { |sum, (item, weight)| sum + weight }
end


##
# Superclase para representar la jugada a seleccionar por el usuario.
# Las clases que heredan esta superclase son:
# * Piedra
# * Papel
# * Tijeras
# * Lagarto
# * Spock 

class Jugada
	##
	# Representa la forma de la mano escogida por el usuario. 
	attr_reader :jugada

	##
	# Crea una nueva jugada a partir del string ingresado como argumento

	def initialize(mano)
		@jugada = mano
	end
	
	##
	# Mostrar la mano como string

	def to_s
		s = @jugada
		s
	end

end

##
# Subclase para representar la jugada Piedra

class Piedra < Jugada

	## 
	# Determina el resultado de la ronda dependiendo de la jugada realizada por el otro jugador.  
	# Devuelve [1,0] si la piedra gana a la otra jugada  
	# Devuelve [1,0] si la piedra pierde contra la otra jugada  
	# Devuelve [0,0] si ambas jugadas son piedra  
	# Levanta una excepcion si el movimiento no es valido.  
	# [Argumentos ] j (jugada)  
	
	def puntos(j)
		if j.to_s == "tijeras"
			resultado = [1,0]
		elsif j.to_s == "papel" 
			resultado = [0,1]
		elsif j.to_s == "spock"
			resultado = [0,1]
		elsif j.to_s == "lagarto"
			resultado = [1,0]
		elsif j.to_s == "piedra"
			resultado = [0,0]
		else
			raise "Movimiento invalido"
		end
		resultado
	end
end

##
# Subclase para representar la jugada Papel

class Papel < Jugada

	## 
	# Determina el resultado de la ronda dependiendo de la jugada realizada por el otro jugador.  
	# Devuelve [1,0] si el papel gana a la otra jugada  
	# Devuelve [1,0] si el papel pierde contra la otra jugada  
	# Devuelve [0,0] si ambas jugadas son papel  
	# Levanta una excepcion si el movimiento no es valido.  
	# [Argumentos ] j (jugada) 

	def puntos(j)
		if j.to_s == "piedra"
			resultado = [1,0]
		elsif j.to_s == "tijeras"
			resultado = [0,1]
		elsif j.to_s == "spock"
			resultado = [1,0]
		elsif j.to_s == "lagarto"
			resultado = [0,1]
		elsif j.to_s == "papel"
			resultado = [0,0]
		else
			raise "Movimiento invalido"
		end
		resultado
	end
end		

##
# Subclase para representar la jugada Tijeras

class Tijeras < Jugada

	## 
	# Determina el resultado de la ronda dependiendo de la jugada realizada por el otro jugador.
	# Devuelve [1,0] si las tijeras ganan a la otra jugada
	# Devuelve [1,0] si las tijeras pierden contra la otra jugada
	# Devuelve [0,0] si ambas jugadas son tijeras
	# Levanta una excepcion si el movimiento no es valido.
	# [Argumentos ] j (jugada) 

	def puntos(j)
		if j.to_s == "papel"
			resultado = [1,0]
		elsif j.to_s == "piedra"
			resultado = [0,1]
		elsif j.to_s == "spock"
			resultado = [0,1]
		elsif j.to_s == "lagarto"
			resultado = [1,0]
		elsif j.to_s == "tijeras"
			resultado = [0,0]
		else
			raise "Movimiento invalido"
		end					
		resultado
	end
end	

##
# Subclase para representar la jugada Spock

class Spock < Jugada

	## 
	# Determina el resultado de la ronda dependiendo de la jugada realizada por el otro jugador.  
	# Devuelve [1,0] si el spock gana a la otra jugada  
	# Devuelve [1,0] si el spock pierde contra la otra jugada  
	# Devuelve [0,0] si ambas jugadas son spock  	
	# Levanta una excepcion si el movimiento no es valido.
	# [Argumentos ] j (jugada) 

	def puntos(j)
		if j.to_s == "piedra"
			resultado = [1,0]
		elsif j.to_s == "papel"
			resultado = [0,1]
		elsif j.to_s == "lagarto"
			resultado = [0,1]
		elsif j.to_s == "tijeras"
			resultado = [1,0]
		elsif j.to_s == "spock"
			resultado = [0,0]
		else 
			raise "Movimiento invalido"
		end
		resultado
	end
end

##
# Subclase para representar la jugada Lagarto

class Lagarto < Jugada

	## 
	# Determina el resultado de la ronda dependiendo de la jugada realizada por el otro jugador.  
	# Devuelve [1,0] si el lagarto gana a la otra jugada  
	# Devuelve [1,0] si el lagarto pierde contra la otra jugada  
	# Devuelve [0,0] si ambas jugadas son lagarto  
	# Levanta una excepcion si el movimiento no es valido.
	# [Argumentos ] j (jugada) 

	def puntos(j)
		if j.to_s == "papel"
			resultado = [1,0]
		elsif j.to_s == "piedra"
			resultado = [0,1]
		elsif j.to_s == "tijeras"
			resultado = [0,1]
		elsif j.to_s == "spock"
			resultado = [1,0]
		elsif j.to_s == "lagarto"
			resultado = [0,0]
		else 
			raise "Movimiento invalido"
		end
		resultado
	end
end	


##
# Clase para representar a los jugadores, cuenta con las especializaciones:
# * Manual
# * Uniforme
# * Sesgada
# * Copiar
# * Pensar

class Estrategia
	
	# Nombre del jugador 
	attr_accessor :nombre 			  
	# jugadas
	attr_accessor :patron
	# Constante para ser usada en generador de numeros al azar
	attr_accessor :semilla


	##
	# Constructor de la clase
	# [Argumentos ] nombre, patron
	# La constante semilla tiene el valor 42

	def initialize (nombre, patron)
		@nombre = nombre
		@patron = patron
		@semilla = 42
		@random = Random.new(@semilla)
	end

	##
	# get del atributo patron

	def getPatron
		@patron
	end

	##
	# to String de la clase  
	# Devuelve el nombre del jugador

	def to_s
		s = "El jugador " + @nombre
	end
	
end		

##
# Especializacion de Estrategia, sigue una distribucion uniforme a partir de un arreglo de jugadas. 

class Uniforme < Estrategia
	
	# Nombre del jugador
	attr_accessor :nombre
	# jugada
	attr_accessor :patron
	# arreglo de jugadas
	attr_accessor :jugadas

	##
	# Constructor que recibe nombre, patron y jugadas  
	# Levanta una excepcion si el arreglo es vacio y elimina duplicados

	def initialize (nombre, patron, jugadas)
		@nombre = nombre
		@patron = patron
		if jugadas.length < 1
			raise "Error"
		end
		
		@jugadas = jugadas.uniq
	end


	## 
	# Proxima jugada a realizar. 

	def prox
		@jugadas.sample
	end

	##
	# to String 
	# Devuelve el nombre del jugados con la estrategia Uniforme

	def to_s
		s = "El jugador " + @nombre + " con la estrategia Uniforme"
	end
end


##
# Especializacion de Estrategia, el metodo asociado recibe un mapa de movimientos posibles y sus probabilidades asociadas, 
# de modo que cada jugada use una distribución sesgada de esa forma

class Sesgada < Estrategia
	# Nombre
	attr_accessor :nombre
	# jugada
	attr_accessor :patron
	# Mapa de jugadas
	attr_accessor :jugadas

	## 
	# Constructor que recibe el nombre, la jugada y el mapa de jugadas
	
	def initialize (nombre, patron, jugadas)
		@nombre = nombre
		@patron = patron
		if jugadas.length < 1
			raise "Error"
		end

		@jugadas = jugadas
	end
	
	##
	# Selecciona la proxima jugada de forma aleatoria con la funcion random_weighted
	
	def prox
		random_weighted @jugadas
		
	end
	
	##
	# to String  
	# Devuelve el nombre del jugador con la estrategia Sesgada

	def to_s
		s = "El jugador " + @nombre + " con la estrategia Sesgada"
	end
end

##
# Especializacion de Estrategia, depende de jugadas anteriores

class Pensar < Estrategia

	##
	# Constructor de la clase
	# Recibe nombre y patron de la superclase  
	# Inicializa en 0 a las variables r,p,t,l,s que representan 
	# la cantidad de veces que el jugador ha utilizado piedra, papel, tijeras
	# lagarto, spock, respectivamente.

	def initialize (nombre, patron)
		super(nombre, patron)
		@r = 0
		@p = 0
		@t = 0
		@l = 0
		@s = 0
	end

	##
	# Actualiza el valor de la variables r,p,t,l,s dependiendo de la
	# jugada realizada.

	def prox m
		if m.to_s == "papel"
			@p += 1
		elsif m.to_s == "piedra"
			@r += 1
		elsif m.to_s == "tijeras"
			@t += 1
		elsif m.to_s == "spock"
			@s += 1
		elsif m.to_s == "lagarto"
			@l += 1
		elsif m.to_s == ""
			# no hacer nada
		else
			raise "Error."
		end

		max = @p + @r + @t + @l + @s -1
		if max <= 0
			max = 0
			n = 0
		else

			
			n = @random.rand(max)
		end

		puts "EL NUM ES #{n}"

		if (n >= 0 and n < @r) or (n == 0)
			mano = Piedra.new("piedra")
		elsif n >= @r and n < @r+@p 
			mano = Papel.new("papel")
		elsif n >= @r+@p and n < @r+@p+@t
			mano = Tijeras.new("tijeras")
		elsif n >= @r+@p+@t and n < @r+@p+@t+@l
			mano = Lagarto.new("lagarto")
		elsif n >= @r+@p+@t+@l and n < @r+@p+@t+@l+@s
			mano = Spock.new("spock")
		end

		mano			
			
	end

	##
	# Resetea los valores de las variables r,p,s,l,s a 0

	def reset
		@r = 0
		@p = 0
		@t = 0
		@l = 0
		@s = 0
	end

end

##
# Especializacion de Estrategia, recibe las jugadas de forma Manual
# (una por una)

class Manual < Estrategia
	##
	# Devuelve los objetos que representan las jugadas

	def prox(m)
		if m == "papel"
			@patron = Papel.new("papel")
		elsif m == "piedra"
			@patron = Piedra.new("piedra")
		elsif m == "tijeras"
			@patron = Tijeras.new("tijeras")
		elsif m == "spock"
			@patron = Spock.new("spock")
		elsif m == "lagarto"
			@patron = Lagarto.new("lagarto")
		else
			raise "Error."
		end
	end

	##
	# to String    
	# Devuelve el nombre del jugador con la estrategia manual
	def to_s
		s = "El jugador " + @nombre + " con de la estrategia Manual"
	end
end


##
# Especializacion de Estrategia, donde se copia la jugada del jugador 
# 2 a partir de la segunda ronda

class Copiar < Estrategia



	def prox(m)
		if m.to_s == "papel"
			@patron = Papel.new("papel")
		elsif m.to_s == "piedra"
			@patron = Piedra.new("piedra")
		elsif m.to_s == "tijeras"
			@patron = Tijeras.new("tijeras")
		elsif m.to_s == "spock"
			@patron = Spock.new("spock")
		elsif m.to_s == "lagarto"
			@patron = Lagarto.new("lagarto")
		else
			raise "Error."
		end
		@patron				
	end

	def to_s
		s = "El jugador " + @nombre + " con la estrategia Copiar"
	end

	
end	



titulo = "Piedra Papel Tijeras Lagarto Spock"


##
# Clase donde ocurre el juego con dos participantes
class Partida

	def initialize app
		# Interfaz grafica
		@app = app
		# Estrategia jugador 1
		@s1 = ""
		# Estrategia jugador 2
		@s2 = ""
		# Puntos a alcanzar
		@puntos = ""
		# Numero de rondas a jugar
		@rondas = ""
		# Jugada del jugador 1
		@j1 = ""
		# Nombre del jugador 2
		@j2 = ""
		@resultado = Hash["1" => 0, "2" => 0, "rondas" => 0]
	end

	##
	# pantallaInicial
	# Muestra la primera pantalla con la presentacion del juego
	def pantallaInicial

		@app.clear
		@app.background "fondo.jpg"
		@inicio = @app.stack :top => "180", :left => "330"
		@inicio.caption "Bienvenido al Juego"
		@inicio.tagline "Piedra Papel Tijeras Lagarto Spock"
		@botonInicio = @inicio.button "Empezar"
		@botonFinal = @inicio.button "Salir"
		
		@botonInicio.click do
			pantallaEstrategias "1"

			@sig = @estrategias.button "Siguiente"
			@sig.click do
				pantallaEstrategias "2"
				@sig2 = @estrategias.button "Siguiente"
				@sig2.click do
					
					pantallaPuntosRondas

				end
			end
			

		end

		@botonFinal.click do
			@app.close
		end
	end

	##
	# pantallaEstrategias
	# Muestra la pantalla que permite seleccionar las estrategias
	def pantallaEstrategias nombre
		
		# Esr¿trategia a escoger por el usuario
		estrategia = ""
		
		# Limpiamos pantalla
		@app.clear
		@app.background "fondo.jpg"

		# stack de botones
		@estrategias = @app.stack :top => "130", :left => "400"
		
		@estrategias.caption "Jugador #{nombre}"
		@estrategias.caption "Escoge una estrategia de juego"
		
		# Estrategia manual
		@manual = @estrategias.button "Manual"
		@manual.click do
			estrategia = "manual"
			if (nombre == "1")
				@s1 = estrategia
			else
				@s2 = estrategia
			end
		end

		# EStrategia uniforme
		@uni = @estrategias.button "Uniforme"
		@uni.click do
			estrategia = "uniforme"
			if (nombre == "1")
				@s1 = estrategia
			else
				@s2 = estrategia
			end
		end

		# Estrategia sesgada
		@ses = @estrategias.button "Sesgada"
		@ses.click do
			estrategia = "sesgada"
			if (nombre == "1")
				@s1 = estrategia
			else
				@s2 = estrategia
			end
		end

		# Estrategia copiar
		@copiar = @estrategias.button "Copiar"
		@copiar.click do
			estrategia = "copiar"
			if (nombre == "1")
				@s1 = estrategia
			else
				@s2 = estrategia
			end
		end

		# Estrategia pensar
		@pensar = @estrategias.button "Pensar"
		@pensar.click do

			estrategia = "pensar"
			if (nombre == "1")
				@s1 = estrategia
			else
				@s2 = estrategia
			end
		end

		
		
	end

	##
	# pantallaPuntosRondas
	# Muestra pantalla que permite seleccionar los puntos y rondas a jugar
	def pantallaPuntosRondas
		puntos = ""
		rondas = ""

		# Limpiamos pantalla
		@app.clear
		@app.background "fondo.jpg"

		@boxes = @app.stack :top => "180", :left => "330"
		@boxes.para "Rondas"
		@r = @boxes.edit_line
     	@boxes.para "Puntos"
     	@pu = @boxes.edit_line
     	@enviar = @boxes.button "OK"
     	@enviar.click do
	     	@rondas = @r.text
			@puntos = @pu.text
			if (@rondas == "" and @puntos == "")
				@boxes.append "Debe indicar un numero de rondas o puntos."
			else
				pantallaJuego
			end
		end
     	
	end

	##
	# pantallaJuego
	# Inicializa las estrategia y arranca el juego
	def pantallaJuego
		@app.clear
		@app.background "fondo.jpg"

		# Inicializar estrategias y crear partida

		piedra = Piedra.new ("piedra")
		papel = Papel.new ("papel")
		tijeras = Tijeras.new ("tijeras")
		lagarto = Lagarto.new ("lagarto")
		spock = Spock.new ("spock")
		pesos = Hash[piedra => 2, papel => 5, tijeras => 4, lagarto => 3, spock => 1]


		if @s1 == "uniforme"
			@j1 =  Uniforme.new "1", "uniforme", [piedra, papel, tijeras, lagarto, spock]
		elsif @s1 == "sesgada"
			@j1 = Sesgada.new "1", "sesgada", pesos
		elsif @s1 == "manual"
			@j1 = Manual.new "1", "manual"
		elsif @s1 == "copiar"
			@j1 = Copiar.new "1", "copiar"
		elsif @s1 == "pensar"
			@j1 = Pensar.new "1", "pensar"
		end
			
		if @s2 == "uniforme"
			@j2 =  Uniforme.new "2", "uniforme", [piedra, papel, tijeras, lagarto, spock]
		elsif @s2 == "sesgada"
			@j2 = Sesgada.new "2", "sesgada", pesos
		elsif @s2 == "manual"
			@j2 = Manual.new "2", "manual"
		elsif @s2 == "copiar"
			@j2 = Copiar.new "2", "copiar"
		elsif @s2 == "pensar"
			@j2 = Pensar.new "2", "pensar"
		end

		#m = Partida.new Hash["1" => @j1, "2" => @j2], @app
		
		if @rondas != ""							
			rondas(@rondas.to_i)
		elsif @puntos != ""
			alcanzar(@puntos.to_i)
		end

		
	end

	##
	# rondas
	# Juega el numero de rondas indicado
	def rondas (n)
		@app.clear
		@app.background "versus.jpg"

		manual1 = false
		manual2 = false
		
		# Obtenemos primera jugada del jugador 1
		if @s1 == "copiar"
			mano1 = Piedra.new "piedra"
			jugada1 = mano1.to_s
		elsif @s1 == "uniforme"  or @s1 == "sesgada"
			mano1 = @j1.prox
			jugada1 = mano1.to_s
		elsif @s1 == "pensar"
			mano1 = @j1.prox ""
			jugada1 = mano1.to_s
		elsif @s1 == "manual"
			manual1 = true
			
		end

		# Obtenemos primera jugada del jugador 2
		if @s2 == "copiar"
			mano2 = Papel.new "papel"
			jugada2 = mano2.to_s
		elsif @s2 == "uniforme"  or @s2 == "sesgada"
			mano2 = @j2.prox
			jugada2 = mano2.to_s
		elsif @s2 == "pensar"
			mano2 = @j2.prox mano1
			jugada2 = mano2.to_s
		elsif @s2 == "manual"
			manual2 = true
		end

		if manual1 and manual2
			
			@app.button "piedra" do
				imagen = @app.image "piedra2.png"
				mano1 = Piedra.new "piedra"
			end
			@app.button "papel" do
				imagen = @app.image "papel2.png"
				mano1 = Papel.new "papel"
			end
			@app.button "tijeras" do
				imagen = @app.image "tijeras2.png"
				mano1 = Tijeras.new "tijeras"
			end
			@app.button "spock" do
				imagen = @app.image "spock2.png"
				mano1 = Spock.new "spock"
			end
			@app.button "lagarto" do
				imagen = @app.image "lizard2.png"
				mano1 = Lagarto.new "lagarto"
			end
			
			@grupo = @app.flow :width => '50%', :left=> '500'
			@grupo.button "piedra" do
				imagen = @app.image "piedra.png"
				mano2 = Piedra.new "piedra"
			end
			@grupo.button "papel" do
				imagen = @app.image "papel.png"
				mano2 = Papel.new "papel"
			end
			@grupo.button "tijeras" do
				imagen = @app.image "tijeras.png"
				mano2 = Tijeras.new "tijeras"
			end
			@grupo.button "spock" do
				imagen = @app.image "spock.png"
				mano2 = Spock.new "spock"
			end
			@grupo.button "lagarto" do
				imagen = @app.image "lizard.png"
				mano2 = Lagarto.new "lagarto"
			end

			@grupo.button  "Siguiente" do
				puntaje = mano1.puntos(mano2)

				# El primer valor de la tupla obtenida es el puntaje del jugador 1
				@resultado["1"] += puntaje[0]

				# El segundo valor de la tupla obtenida es el puntaje del jugador 2
				@resultado["2"] += puntaje[1]
				if puntaje[0] == 1
					@app.para "El ganador de esta ronda es el jugador 1"
				elsif puntaje[1] == 1
					
					@app.para "El ganador de esta ronda es el jugador 2"
				else 
					@app.para "Empate"
				end

				@resultado["rondas"] += 1

				if @resultado["rondas"] == n
					@rondas = ""
					pantallaResultado @resultado	
					
				end
			end

		elsif manual1

			@app.button "piedra" do
				imagen = @app.image "piedra2.png"
				mano1 = Piedra.new "piedra"
			end
			@app.button "papel" do
				imagen = @app.image "papel2.png"
				mano1 = Papel.new "papel"
			end
			@app.button "tijeras" do
				imagen = @app.image "tijeras2.png"
				mano1 = Tijeras.new "tijeras"
			end
			@app.button "spock" do
				imagen = @app.image "spock2.png"
				mano1 = Spock.new "spock"
			end
			@app.button "lagarto" do
				imagen = @app.image "lizard2.png"
				mano1 = Lagarto.new "lagarto"
			end
			


			@app.button "jugar" do
				if jugada2 == "piedra"
					@app.stack :top => '200', :left => '580', :width => '200', :height => '300' do
						imagen = @app.image "piedra.png"
					end

				elsif jugada2 == "papel"
					@app.stack :top => '200', :left => '580', :width => '200', :height => '300' do
						imagen = @app.image "papel.png"
					end

				elsif jugada2 == "tijeras"
					@app.stack :top => '200', :left => '580', :width => '200', :height => '300' do
						imagen = @app.image "tijeras.png"
					end

				elsif jugada2 == "lagarto"
					@app.stack :top => '200', :left => '580', :width => '200', :height => '300' do
						imagen = @app.image "lizard.png"
					end

				elsif jugada2 == "spock"
					@app.stack :top => '200', :left => '580', :width => '200', :height => '300' do
						imagen = @app.image "spock.png"
					end
				end
				puntaje = mano1.puntos(mano2)

				# El primer valor de la tupla obtenida es el puntaje del jugador 1
				@resultado["1"] += puntaje[0]

				# El segundo valor de la tupla obtenida es el puntaje del jugador 2
				@resultado["2"] += puntaje[1]
				if puntaje[0] == 1
					@app.para "El ganador de esta ronda es el jugador 1"
				elsif puntaje[1] == 1
					
					@app.para "El ganador de esta ronda es el jugador 2"
				else 
					@app.para "Empate"
				end


				if @resultado["rondas"] == n
					@rondas = ""
					pantallaResultado @resultado	
					
				end
				@resultado["rondas"] += 1

				if @s2 == "copiar"
					mano2 = @j2.prox mano1
					jugada2 = mano2.to_s
				elsif @s2 == "uniforme"  or @s2 == "sesgada"
					mano2 = @j2.prox
					jugada2 = mano2.to_s
				elsif @s2 == "pensar"
					mano2 = @j2.prox mano1
					jugada2 = mano2.to_s
				elsif @s2 == "manual"
					manual2 = true
				end
			end


			

		elsif manual2
			@app.button "jugar" do

				if jugada1 == "piedra"
					@app.stack :top => '200', :left => '40', :width => '200', :height => '300' do
						imagen = @app.image "piedra2.png"
					end

				elsif jugada1 == "papel"
					@app.stack :top => '200', :left => '40', :width => '200', :height => '300' do
						imagen = @app.image "papel2.png"
							
					end

				elsif jugada1 == "tijeras"
					@app.stack :top => '200', :left => '40', :width => '200', :height => '300' do
						imagen = @app.image "tijeras2.png"
							
					end

				elsif jugada1 == "lagarto"
					@app.stack :top => '200', :left => '40', :width => '200', :height => '300' do
						imagen = @app.image "lizard2.png"
					end

				elsif jugada1 == "spock"
					@app.stack :top => '200', :left => '40', :width => '200', :height => '300' do
						imagen = @app.image "spock2.png"
					end
				end
			end
			
			@grupo = @app.flow :width => '50%', :left=> '500'
			@grupo.button "piedra" do
				imagen = @app.image "piedra.png"
				mano2 = Piedra.new "piedra"
			end
			@grupo.button "papel" do
				imagen = @app.image "papel.png"
				mano2 = Papel.new "papel"
			end
			@grupo.button "tijeras" do
				imagen = @app.image "tijeras.png"
				mano2 = Tijeras.new "tijeras"
			end
			@grupo.button "spock" do
				imagen = @app.image "spock.png"
				mano2 = Spock.new "spock"
			end
			@grupo.button "lagarto" do
				imagen = @app.image "lizard.png"
				mano2 = Lagarto.new "lagarto"
			end

			@grupo.button "siguiente" do

				puntaje = mano1.puntos(mano2)

				# El primer valor de la tupla obtenida es el puntaje del jugador 1
				@resultado["1"] += puntaje[0]

				# El segundo valor de la tupla obtenida es el puntaje del jugador 2
				@resultado["2"] += puntaje[1]
				if puntaje[0] == 1
					@app.para "El ganador de esta ronda es el jugador 1"
				elsif puntaje[1] == 1
					
					@app.para "El ganador de esta ronda es el jugador 2"
				else 
					@app.para "Empate"
				end


				if @resultado["rondas"] == n 
					@rondas = ""
					pantallaResultado @resultado	
					
				end
				@resultado["rondas"] += 1
				if @s1 == "copiar"
					mano1 = mano2
					jugada1 = mano1.to_s
				elsif @s1 == "uniforme"  or @s1 == "sesgada"
					mano1 = @j1.prox
					jugada1 = mano1.to_s
				elsif @s1 == "pensar"
					mano1 = @j1.prox mano2
					jugada1 = mano1.to_s
				elsif @s1 == "manual"
					manual1 = true
			
				end
			end


		else
			@jugar = @app.button "jugar"
			@jugar.click do

				if jugada1 == "piedra"
					@app.stack :top => '200', :left => '40', :width => '200', :height => '300' do
						imagen = @app.image "piedra2.png"
					end

				elsif jugada1 == "papel"
					@app.stack :top => '200', :left => '40', :width => '200', :height => '300' do
						imagen = @app.image "papel2.png"
							
					end

				elsif jugada1 == "tijeras"
					@app.stack :top => '200', :left => '40', :width => '200', :height => '300' do
						imagen = @app.image "tijeras2.png"
							
					end

				elsif jugada1 == "lagarto"
					@app.stack :top => '200', :left => '40', :width => '200', :height => '300' do
						imagen = @app.image "lizard2.png"
					end

				elsif jugada1 == "spock"
					@app.stack :top => '200', :left => '40', :width => '200', :height => '300' do
						imagen = @app.image "spock2.png"
					end
				end

				if jugada2 == "piedra"
					@app.stack :top => '200', :left => '580', :width => '200', :height => '300' do
						imagen = @app.image "piedra.png"
					end

				elsif jugada2 == "papel"
					@app.stack :top => '200', :left => '580', :width => '200', :height => '300' do
						imagen = @app.image "papel.png"
					end

				elsif jugada2 == "tijeras"
					@app.stack :top => '200', :left => '580', :width => '200', :height => '300' do
						imagen = @app.image "tijeras.png"
					end

				elsif jugada2 == "lagarto"
					@app.stack :top => '200', :left => '580', :width => '200', :height => '300' do
						imagen = @app.image "lizard.png"
					end

				elsif jugada2 == "spock"
					@app.stack :top => '200', :left => '580', :width => '200', :height => '300' do
						imagen = @app.image "spock.png"
					end
				end

				puntaje = mano1.puntos(mano2)

				# El primer valor de la tupla obtenida es el puntaje del jugador 1
				@resultado["1"] += puntaje[0]

				# El segundo valor de la tupla obtenida es el puntaje del jugador 2
				@resultado["2"] += puntaje[1]
				if puntaje[0] == 1
					@app.para "El ganador de esta ronda es el jugador 1"
				elsif puntaje[1] == 1
					
					@app.para "El ganador de esta ronda es el jugador 2"
				else 
					@app.para "Empate"
				end


				if @resultado["rondas"] == n
					@rondas = ""
					pantallaResultado @resultado
					
				end
				@resultado["rondas"] += 1

				# if @resultado[@j1] == n or @resultado[@j2] == n 
					
				# 	pantallaResultado @resultado	
					
				# end

				mano1Aux = mano1
				if @s1 == "copiar"
					mano1 = mano2
					jugada1 = mano1.to_s
				elsif @s1 == "uniforme"  or @s1 == "sesgada"
					mano1 = @j1.prox
					jugada1 = mano1.to_s
				elsif @s1 == "pensar"
					mano1 = @j1.prox mano2
					jugada1 = mano1.to_s
				elsif @s1 == "manual"
					manual1 = true
			
				end
				if @s2 == "copiar"
					mano2 = @j2.prox mano1Aux
					jugada2 = mano2.to_s
				elsif @s2 == "uniforme"  or @s2 == "sesgada"
					mano2 = @j2.prox
					jugada2 = mano2.to_s
				elsif @s2 == "pensar"
					
					mano2 = @j2.prox mano1Aux
					jugada2 = mano2.to_s
				elsif @s2 == "manual"
					manual2 = true
				end

			end
		end
	end

	##
	# alcanzar
	# Juega el numero de puntos indicado
	def alcanzar (n)
		@app.clear
		@app.background "versus.jpg"

		manual1 = false
		manual2 = false
		
		# Obtenemos primera jugada del jugador 1
		if @s1 == "copiar"
			mano1 = Piedra.new "piedra"
			jugada1 = mano1.to_s
		elsif @s1 == "uniforme"  or @s1 == "sesgada"
			mano1 = @j1.prox
			jugada1 = mano1.to_s
		elsif @s1 == "pensar"
			mano1 = @j1.prox ""
			jugada1 = mano1.to_s
		elsif @s1 == "manual"
			manual1 = true
			
		end

		# Obtenemos primera jugada del jugador 2
		if @s2 == "copiar"
			mano2 = Papel.new "papel"
			jugada2 = mano2.to_s
		elsif @s2 == "uniforme"  or @s2 == "sesgada"
			mano2 = @j2.prox
			jugada2 = mano2.to_s
		elsif @s2 == "pensar"
			mano2 = @j2.prox mano1
			jugada2 = mano2.to_s
		elsif @s2 == "manual"
			manual2 = true
		end

		if manual1 and manual2
			
			@app.button "piedra" do
				imagen = @app.image "piedra2.png"
				mano1 = Piedra.new "piedra"
			end
			@app.button "papel" do
				imagen = @app.image "papel2.png"
				mano1 = Papel.new "papel"
			end
			@app.button "tijeras" do
				imagen = @app.image "tijeras2.png"
				mano1 = Tijeras.new "tijeras"
			end
			@app.button "spock" do
				imagen = @app.image "spock2.png"
				mano1 = Spock.new "spock"
			end
			@app.button "lagarto" do
				imagen = @app.image "lizard2.png"
				mano1 = Lagarto.new "lagarto"
			end
			
			@grupo = @app.flow :width => '50%', :left=> '500'
			@grupo.button "piedra" do
				imagen = @app.image "piedra.png"
				mano2 = Piedra.new "piedra"
			end
			@grupo.button "papel" do
				imagen = @app.image "papel.png"
				mano2 = Papel.new "papel"
			end
			@grupo.button "tijeras" do
				imagen = @app.image "tijeras.png"
				mano2 = Tijeras.new "tijeras"
			end
			@grupo.button "spock" do
				imagen = @app.image "spock.png"
				mano2 = Spock.new "spock"
			end
			@grupo.button "lagarto" do
				imagen = @app.image "lizard.png"
				mano2 = Lagarto.new "lagarto"
			end

			@grupo.button  "Siguiente" do

				puntaje = mano1.puntos(mano2)

				# El primer valor de la tupla obtenida es el puntaje del jugador 1
				@resultado["1"] += puntaje[0]

				# El segundo valor de la tupla obtenida es el puntaje del jugador 2
				@resultado["2"] += puntaje[1]
				if puntaje[0] == 1
					@app.para "El ganador de esta ronda es el jugador 1"
				elsif puntaje[1] == 1
					
					@app.para "El ganador de esta ronda es el jugador 2"
				else 
					@app.para "Empate"
				end

				@resultado["rondas"] += 1

				if @resultado["1"] == n or @resultado["2"] == n 
					@puntos = ""
					pantallaResultado @resultado	
					
				end
			end

		elsif manual1

			@app.button "piedra" do
				imagen = @app.image "piedra2.png"
				mano1 = Piedra.new "piedra"
			end
			@app.button "papel" do
				imagen = @app.image "papel2.png"
				mano1 = Papel.new "papel"
			end
			@app.button "tijeras" do
				imagen = @app.image "tijeras2.png"
				mano1 = Tijeras.new "tijeras"
			end
			@app.button "spock" do
				imagen = @app.image "spock2.png"
				mano1 = Spock.new "spock"
			end
			@app.button "lagarto" do
				imagen = @app.image "lizard2.png"
				mano1 = Lagarto.new "lagarto"
			end

			@app.button "jugar" do
				if jugada2 == "piedra"
					@app.stack :top => '200', :left => '580', :width => '200', :height => '300' do
						imagen = @app.image "piedra.png"
					end

				elsif jugada2 == "papel"
					@app.stack :top => '200', :left => '580', :width => '200', :height => '300' do
						imagen = @app.image "papel.png"
					end

				elsif jugada2 == "tijeras"
					@app.stack :top => '200', :left => '580', :width => '200', :height => '300' do
						imagen = @app.image "tijeras.png"
					end

				elsif jugada2 == "lagarto"
					@app.stack :top => '200', :left => '580', :width => '200', :height => '300' do
						imagen = @app.image "lizard.png"
					end

				elsif jugada2 == "spock"
					@app.stack :top => '200', :left => '580', :width => '200', :height => '300' do
						imagen = @app.image "spock.png"
					end
				end
				puntaje = mano1.puntos(mano2)

				# El primer valor de la tupla obtenida es el puntaje del jugador 1
				@resultado["1"] += puntaje[0]

				# El segundo valor de la tupla obtenida es el puntaje del jugador 2
				@resultado["2"] += puntaje[1]
				if puntaje[0] == 1
					@app.para "El ganador de esta ronda es el jugador 1"
				elsif puntaje[1] == 1
					
					@app.para "El ganador de esta ronda es el jugador 2"
				else 
					@app.para "Empate"
				end


				if @resultado["1"] == n or @resultado["2"] == n 
					@puntos = ""
					pantallaResultado @resultado	
					
				end
				@resultado["rondas"] += 1

				if @s2 == "copiar"
					mano2 = @j2.prox mano1
					jugada2 = mano2.to_s
				elsif @s2 == "uniforme"  or @s2 == "sesgada"
					mano2 = @j2.prox
					jugada2 = mano2.to_s
				elsif @s2 == "pensar"
					mano2 = @j2.prox mano1
					jugada2 = mano2.to_s
				elsif @s2 == "manual"
					manual2 = true
				end
			end


			

		elsif manual2
			@app.button "jugar" do

				if jugada1 == "piedra"
					@app.stack :top => '200', :left => '40', :width => '200', :height => '300' do
						imagen = @app.image "piedra2.png"
					end

				elsif jugada1 == "papel"
					@app.stack :top => '200', :left => '40', :width => '200', :height => '300' do
						imagen = @app.image "papel2.png"
							
					end

				elsif jugada1 == "tijeras"
					@app.stack :top => '200', :left => '40', :width => '200', :height => '300' do
						imagen = @app.image "tijeras2.png"
							
					end

				elsif jugada1 == "lagarto"
					@app.stack :top => '200', :left => '40', :width => '200', :height => '300' do
						imagen = @app.image "lizard2.png"
					end

				elsif jugada1 == "spock"
					@app.stack :top => '200', :left => '40', :width => '200', :height => '300' do
						imagen = @app.image "spock2.png"
					end
				end
			end
			
			@grupo = @app.flow :width => '50%', :left=> '500'
			@grupo.button "piedra" do
				imagen = @app.image "piedra.png"
				mano2 = Piedra.new "piedra"
			end
			@grupo.button "papel" do
				imagen = @app.image "papel.png"
				mano2 = Papel.new "papel"
			end
			@grupo.button "tijeras" do
				imagen = @app.image "tijeras.png"
				mano2 = Tijeras.new "tijeras"
			end
			@grupo.button "spock" do
				imagen = @app.image "spock.png"
				mano2 = Spock.new "spock"
			end
			@grupo.button "lagarto" do
				imagen = @app.image "lizard.png"
				mano2 = Lagarto.new "lagarto"
			end

			@grupo.button "siguiente" do

				puntaje = mano1.puntos(mano2)

				# El primer valor de la tupla obtenida es el puntaje del jugador 1
				@resultado["1"] += puntaje[0]

				# El segundo valor de la tupla obtenida es el puntaje del jugador 2
				@resultado["2"] += puntaje[1]
				if puntaje[0] == 1
					@app.para "El ganador de esta ronda es el jugador 1"
				elsif puntaje[1] == 1
					
					@app.para "El ganador de esta ronda es el jugador 2"
				else 
					@app.para "Empate"
				end


				if @resultado["1"] == n or @resultado["2"] == n 
					@puntos = ""
					pantallaResultado @resultado	
					
				end

				@resultado["rondas"] += 1
				if @s1 == "copiar"
					mano1 = mano2
					jugada1 = mano1.to_s
				elsif @s1 == "uniforme"  or @s1 == "sesgada"
					mano1 = @j1.prox
					jugada1 = mano1.to_s
				elsif @s1 == "pensar"
					mano1 = @j1.prox mano2
					jugada1 = mano1.to_s
				elsif @s1 == "manual"
					manual1 = true
			
				end
			end

		else
			@jugar = @app.button "jugar"
			@jugar.click do

				if jugada1 == "piedra"
					@app.stack :top => '200', :left => '40', :width => '200', :height => '300' do
						imagen = @app.image "piedra2.png"
					end

				elsif jugada1 == "papel"
					@app.stack :top => '200', :left => '40', :width => '200', :height => '300' do
						imagen = @app.image "papel2.png"
							
					end

				elsif jugada1 == "tijeras"
					@app.stack :top => '200', :left => '40', :width => '200', :height => '300' do
						imagen = @app.image "tijeras2.png"
							
					end

				elsif jugada1 == "lagarto"
					@app.stack :top => '200', :left => '40', :width => '200', :height => '300' do
						imagen = @app.image "lizard2.png"
					end

				elsif jugada1 == "spock"
					@app.stack :top => '200', :left => '40', :width => '200', :height => '300' do
						imagen = @app.image "spock2.png"
					end
				end

				if jugada2 == "piedra"
					@app.stack :top => '200', :left => '580', :width => '200', :height => '300' do
						imagen = @app.image "piedra.png"
					end

				elsif jugada2 == "papel"
					@app.stack :top => '200', :left => '580', :width => '200', :height => '300' do
						imagen = @app.image "papel.png"
					end

				elsif jugada2 == "tijeras"
					@app.stack :top => '200', :left => '580', :width => '200', :height => '300' do
						imagen = @app.image "tijeras.png"
					end

				elsif jugada2 == "lagarto"
					@app.stack :top => '200', :left => '580', :width => '200', :height => '300' do
						imagen = @app.image "lizard.png"
					end

				elsif jugada2 == "spock"
					@app.stack :top => '200', :left => '580', :width => '200', :height => '300' do
						imagen = @app.image "spock.png"
					end
				end

				puntaje = mano1.puntos(mano2)

				# El primer valor de la tupla obtenida es el puntaje del jugador 1
				@resultado["1"] += puntaje[0]

				# El segundo valor de la tupla obtenida es el puntaje del jugador 2
				@resultado["2"] += puntaje[1]
				if puntaje[0] == 1
					@app.para "El ganador de esta ronda es el jugador 1"
				elsif puntaje[1] == 1
					
					@app.para "El ganador de esta ronda es el jugador 2"
				else 
					@app.para "Empate"
				end


				
				if @resultado["1"] == n or @resultado["2"] == n 
					@puntos = ""
					pantallaResultado @resultado	
					
				end
				@resultado["rondas"] += 1


				mano1Aux = mano1
				if @s1 == "copiar"
					mano1 = mano2
					jugada1 = mano1.to_s
				elsif @s1 == "uniforme"  or @s1 == "sesgada"
					mano1 = @j1.prox
					jugada1 = mano1.to_s
				elsif @s1 == "pensar"
					mano1 = @j1.prox mano2
					jugada1 = mano1.to_s
				elsif @s1 == "manual"
					manual1 = true
			
				end

				if @s2 == "copiar"
					mano2 = @j2.prox mano1Aux
					jugada2 = mano2.to_s
				elsif @s2 == "uniforme"  or @s2 == "sesgada"
					mano2 = @j2.prox
					jugada2 = mano2.to_s
				elsif @s2 == "pensar"
					mano2 = @j2.prox mano1Aux
					jugada2 = mano2.to_s
				elsif @s2 == "manual"
					manual2 = true
				end

			end
		end
	end

	##
	# pantallaResultado
	# Muestra pantalla con los resultados finales
	def pantallaResultado resultado
		@app.clear
		@app.background "versus.jpg"
		@app.para "juego terminado con #{resultado["rondas"]} rondas"

		# Continuar con el juego si aun hay puntos o rondas que jugar
		# esto sucede si el usuario lleno los dos cuadros de rondas y puntos
		if resultado["1"] > resultado["2"]
			@app.para "El ganador es el jugador 1 con #{resultado["1"]} puntos"
		elsif resultado["1"] < resultado["2"]
			@app.para "El ganador es el jugador 2 con #{resultado["2"]} puntos"
		else
			@app.para "Empate!"
		end

		@app.button "Continuar" do
			if @puntos != ""
				alcanzar(@puntos.to_i)
			elsif @rondas != ""
				rondas(@rondas.to_i)
				
			else
				@app.button "Jugar Otra Vez" do
					@puntos = ""
					@rondas = ""
					pantallaPuntosRondas
				end

				@app.button "Reiniciar Juego" do
					reset
					pantallaInicial
				end

				@app.button "Salir" do
					@app.close
				end
			end
		end

	end

	##
	# reset
	# Reinicia el juego
	def reset 
		@resultado["rondas"] = 0
		@resultado["1"] = 0
		@resultado["2"] = 0
		@s1 = ""
		@s2 = ""
		@j1 = ""
		@j2 = ""
		@puntos = ""
		@rondas = ""
	end

end


# Ventana principal
Shoes.app(width: 1000, height:572, title:titulo) do
	j = Partida.new self
	j.pantallaInicial
end
