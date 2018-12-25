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

##
# Clase donde ocurre el juego con dos participantes

class Partida
	# Nombre del jugador 1
	attr_accessor :j1
	# Nombre del jugador 2
	attr_accessor :j2
	# estrategia del jugador 1
	attr_accessor :s1
	# estrategia del jugador 2
	attr_accessor :s2
	# mapa de resultados
	attr_accessor :resultado

	##
	# Constructor de la clase 
	# 

	def initialize partida
		# Nombres de los jugadores
		@j1 = partida.keys[0]
		@j2 = partida.keys[1]

		# Estrategias de los jugadores
		@s1 = partida.values[0]
		@s2 = partida.values[1]

		# Inicializamos el mapa con los resultados
		@resultado = Hash[j1 => 0, j2 => 0, "rondas" => 0]
	end

	##
	# Completar el numero de rondas indicadas 
	# y actualiza los resultados en el mapa

	def rondas (n)
		# Obtenemos proxima jugada del jugador 1
		if s1.getPatron == "copiar"
			mano1 = Piedra.new "piedra"
		elsif s1.getPatron == "uniforme"  or s1.getPatron == "sesgada"
			mano1 = s1.prox
		elsif s1.getPatron == "pensar"
			mano1 = s1.prox ""

			
		end

		# Obtenemos proxima jugada del jugador 2
		if s2.getPatron == "copiar"
			mano2 = s2.prox mano1
		elsif s2.getPatron == "uniforme"  or s2.getPatron == "sesgada"
			mano2 = s2.prox
		elsif s2.getPatron == "pensar"
			mano2 = s2.prox mano1
		end

		puts s1.to_s
		puts mano1.to_s

		puts s2.to_s
		puts mano2.to_s

		@resultado["rondas"] += 1

		# Obtenemos el puntaje de la ronda
		puntaje = mano1.puntos(mano2)

		# El primer valor de la tupla obtenida es el puntaje del jugador 1
		@resultado[j1] += puntaje[0]

		# El segundo valor de la tupla obtenida es el puntaje del jugador 2
		@resultado[j2] += puntaje[1]


		(2..n).each do |i|
			@resultado["rondas"] += 1

			if s1.getPatron == "copiar"
				mano1 = s1.prox mano2
			elsif s1.getPatron == "uniforme"  or s1.getPatron == "sesgada"
				mano1 = s1.prox
			elsif s1.getPatron == "pensar"
				mano1 = s1.prox mano2
			end

			# Obtenemos proxima jugada del jugador 2
			if s2.getPatron == "copiar"
				mano2 = s2.prox mano1
			elsif s2.getPatron == "uniforme"  or s2.getPatron == "sesgada"
				mano2 = s2.prox
			elsif s2.getPatron == "pensar"
				mano2 = s2.prox mano1
			end

			puts s1.to_s
			puts mano1.to_s

			puts s2.to_s
			puts mano2.to_s

			# Obtenemos el puntaje de la ronda
			puntaje = mano1.puntos(mano2)

			# El primer valor de la tupla obtenida es el puntaje del jugador 1
			@resultado[j1] += puntaje[0]

			# El segundo valor de la tupla obtenida es el puntaje del jugador 2
			@resultado[j2] += puntaje[1]
		end

		@resultado
	end

	##
	# Alcanzar el numero de puntos indicadas 
	# y actualiza los resultados en el mapa

	def alcanzar (n)

		fin = false

		# Obtenemos proxima jugada del jugador 1
		if s1.getPatron == "copiar"
			mano1 = Piedra.new "piedra"
		elsif s1.getPatron == "uniforme"  or s1.getPatron == "sesgada"
			mano1 = s1.prox

		end

		# Obtenemos proxima jugada del jugador 2
		if s2.getPatron == "copiar"
			mano2 = s2.prox mano1
		elsif s2.getPatron == "uniforme" or s2.getPatron == "sesgada" 
			mano2 = s2.prox
		end

		@resultado["rondas"] += 1
		# Obtenemos el puntaje de la ronda
		puntaje = mano1.puntos(mano2)

		# El primer valor de la tupla obtenida es el puntaje del jugador 1
		@resultado[j1] += puntaje[0]

		# El segundo valor de la tupla obtenida es el puntaje del jugador 2
		@resultado[j2] += puntaje[1]

		if (@resultado[j1] == n or @resultado[j2] == n)
			fin = true
		end

		while fin do

			@resultado["rondas"] += 1

			if s1.getPatron == "copiar"
				mano1 = s1.prox mano2
			elsif s1.getPatron == "uniforme"  or s1.getPatron == "sesgada"
				mano1 = s1.prox
			end

			# Obtenemos proxima jugada del jugador 2
			if s2.getPatron == "copiar"
				mano2 = s2.prox mano1
			elsif s2.getPatron == "uniforme"  or s2.getPatron == "sesgada"
				mano2 = s2.prox
			end

			# Obtenemos el puntaje de la ronda
			puntaje = mano1.puntos(mano2)

			# El primer valor de la tupla obtenida es el puntaje del jugador 1
			@resultado[j1] += puntaje[0]

			# El segundo valor de la tupla obtenida es el puntaje del jugador 2
			@resultado[j2] += puntaje[1]

			if (@resultado[j1] == n or @resultado[j2] == n)
				fin = true
			end
		end

		@resultado
	end

	##
	# Resetear mapa de resultados a 0 en sus entradas
	# 

	def reset 
		@resultado["rondas"] = 0
		@resultado[j1] = 0
		@resultado[j2] = 0
	end
end

piedra = Piedra.new ("piedra")
papel = Papel.new ("papel")
tijeras = Tijeras.new ("tijeras")
lagarto = Lagarto.new ("lagarto")
spock = Spock.new ("spock")

j1 = Uniforme.new "Ana", "uniforme", [piedra, papel, tijeras, lagarto, spock]
j2 = Uniforme.new "Juan", "uniforme", [piedra, papel, tijeras, lagarto, spock]

m = Partida.new Hash["Ana" => j1, "Juan" => j2]

r = m.rondas(3)

puts r['Ana']
puts r['Juan']
puts r['rondas']

puts "################"

pesos = Hash[piedra => 2, papel => 5, tijeras => 4, lagarto => 3, spock => 1]


j1 = Sesgada.new "Ana", "sesgada", pesos
j2 = Sesgada.new "Juan", "sesgada", pesos

m = Partida.new Hash["Ana" => j1, "Juan" => j2]

r = m.rondas(3)

puts r['Ana']
puts r['Juan']
puts r['rondas']

puts "################"

j1 = Pensar.new "Ana", "pensar"
j2 = Uniforme.new "Juan", "uniforme", [piedra, papel, tijeras, lagarto, spock]

m = Partida.new Hash["Ana" => j1, "Juan" => j2]

r = m.rondas(20)

puts r['Ana']
puts r['Juan']
puts r['rondas']

puts "################"
