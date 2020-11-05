import players.*
import wollok.game.*
import movimientos.*
import enemys.*
import disparos.*
import pantallaInicio.*
import disparos.*

class Mascota{
	var movimiento = esperando
	
	method position() = movimiento.position()
	
	method aparece(){
		game.schedule(10000,{
			game.addVisual(self)
			game.say(self,"veni a salvarme tengo hambre")
		})
	}
	
	method encuentro(personaje){
		
		game.say(self,"te protegere :)")
		movimiento = seguirDuenio
		personaje.vidaCompleta()
		personaje.cambiarEstado(semiDios)
		personaje.hacerMortal(false)
		game.schedule(20000,{
			game.say(self,"suerte bro")
			game.removeVisual(self)
			personaje.cambiarEstado(simpleMortal)
			personaje.hacerMortal(true)
		})
	}
	
	method encuentra(enemy,tiro){}
	method recibeDisparo(disparo){}
}

object mora inherits Mascota{
    method image() = "mora.png"
}

object junior inherits Mascota{
	method image() = "junior.png"
}

object unicornio inherits Mascota{
	method image() = "unicornio.png"
}

object esperando{
	const valoresY = [0,4,8,12,16]
	const valoresX = [0,1,2,3,4,5,6,7,8,9,14,15,16,17,18,19,20,21,22]
	const x = self.posicionRandomX()
	const y = self.posicionRandomY()
	
	method position() = game.at(x,y)
	
	method posicionRandomX(){
		const posx = 0.randomUpTo(19)
		return valoresX.get(posx)
	}
	method posicionRandomY(){
		const posy = 0.randomUpTo(4)
		return valoresY.get(posy)
	}
}

object seguirDuenio{
	//RESPONSABILIDAD DE LA MASCOTA
	method position() = personajeSeleccionado.personaje().position().left(1)
}