import wollok.game.*
import movimientos.*
import enemys.*
import disparos.*
import pantallaInicio.*
import disparos.*
import mascotas.*

class Player{
    var property position = game.at(11, 0)
    var direccion=izquierda
    var property vida = 101
    var vivo = true
    var property estado = simpleMortal
    var muertesTot = 0   
    var esMortal = true 
    
    method direccion() = direccion
        
    method hacerMortal(vari){
    	esMortal = vari
    }
        
    method vidaCompleta(){
    	vida = 101
    }
    
    method cambiarEstado(nuevoE){
    	estado = nuevoE
    }
    
    method vivo() = vivo
    
    method move(nuevaPosicion){
        position = nuevaPosicion
    }
    
    method moveIzq(){ 
    	if(self.enElFloor() && (tablero.enElTableroReducidoX(self)  || self.position().x() == 22)){
                self.move(self.position().left(1))
                self.nuevaOrientacion(izquierda)
            }
    }
    
    method moveDer(){
    	if(self.enElFloor() && (tablero.enElTableroReducidoX(self) || self.position().x() == 0)){
                self.move(self.position().right(1))
                self.nuevaOrientacion(derecha)
            }
    }
    
    method enElFloor(){
        return (position.y()%4 == 0)
    }

    method perderVida(cantidad){
        vida = (vida-cantidad).max(0)
        self.sterben()
    }
    
    method encuentroEnemigo(cantidad){
    	estado.encuentroEnemigo(cantidad,self)
    }
    
    method recibeDisparo(disparo){
    	 estado.recibeDisparo(disparo,self)
    }

    method nuevaOrientacion(nuevaOrientacion){
        direccion=nuevaOrientacion
    }
    
    method encuentra(enemigo,tiro){}
    
    method sterben(){ //morir
    	if(vida == 0){
    		vivo = false
    		game.say(self,"F")
    		game.schedule(9000, {game.stop()})
    	}else if(vivo){
    		game.say(self,"me esta matando el coloquio de discreta")
    	}
    }
    
    method matoAUno(){
    	muertesTot+=1
    	if(muertesTot == 25)
    		self.sieg()
    }
    
    method sieg(){  //ganar
    	//enemigos.eliminarTodos()
    	game.say(self, "GANE PERRI")
    	//game.schedule(5000, game.addVisual("youWin.png"))
    	game.schedule(10000, {game.stop()})
    }
    
    method image(){
    	if(vivo and esMortal){
        	return personajeSeleccionado.personaje().imagen() + "-der.png"
        }else if (vivo and not esMortal){
        	return	personajeSeleccionado.personaje().imagen() + "Escudo.png"	
        }else{
        	return personajeSeleccionado.personaje().imagen() + "BYN.png"
        }
    }
}

object caro inherits Player{
	
	method mascota() = mora

	method disparo() = "flor.png" 
	
    method imagen() = "caro"
}

object cami inherits Player{
	method disparo() = "rayolaser.png"
	method mascota() = unicornio
	
    method imagen() = "cami"
}

object fran inherits Player{
	method disparo() = "fuego.png"
	method mascota() = junior
	
    method imagen() = "fran"
}


///////////////////////////////////////////////////////////////////

object izquierda{
    method mover(objeto){
    	if(tablero.enElTableroX(objeto)){ 
        	objeto.move(objeto.position().left(1))
        }else{
        	objeto.remove()
        }
    }
}

object derecha{
    method mover(objeto){
        if(tablero.enElTableroX(objeto)){
        	objeto.move(objeto.position().right(1))
        }else{
        	objeto.remove()
        }
    }
}

///////////////////////////////////////////////////////////////////

object elevator{
    var property position = game.at(3, 0)

    method image(){
        return "ascensor (1).png"
    }
    method move(nuevaPosicion) {
            position = nuevaPosicion
    }
    
    method encuentro(player){}
    method encuentra(enemigo,tiro){}
    method recibeDisparo(disparo){
    }
    
    method enElevator(alguien) = alguien.position().x().between(10,13)
    
    method paArriba(){
    	if(self.enElevator(personajeSeleccionado.personaje()) && not enemigos.listaEnemigos().any({enemy => self.enElevator(enemy)})&& (tablero.enElTableroY(self) || self.position().y() == 0)){
                self.move(self.position().up(1))
                personajeSeleccionado.personaje().move(personajeSeleccionado.personaje().position().up(1))
            }
    }
    
    method paAbajo(){
    	if(self.enElevator(personajeSeleccionado.personaje()) && not enemigos.listaEnemigos().any({enemy => self.enElevator(enemy)}) && (tablero.enElTableroY(self) || self.position().y() == 16)){
                self.move(self.position().down(1))
                personajeSeleccionado.personaje().move(personajeSeleccionado.personaje().position().down(1))
            }
    }
}

///////////////////////////////////////////////////////////////////////////////////

object tablero{
	
	method enElTableroY(alguien) = alguien.position().y().between(1,15)
	method enElTableroReducidoX(alguien) = alguien.position().x().between(1,21)
	method enElTableroX(alguien) = alguien.position().x()>0 && alguien.position().x()< game.width()
	method aLaIzqAscensor(alguien) = alguien.position().x()<8
	method aLaDerAscensor(alguien) = alguien.position().x()>15
	
}

//////////////////////////////////////////////////////////////////////////////////

class Estado{
	method recibeDisparo(disparo,personaje){
		tirosEnemigo.desaparecer(disparo)
	}
	method encuentroEnemigo(cantidad, personaje){}
}

object simpleMortal inherits Estado{
	override method recibeDisparo(disparo,personaje){
		super(disparo,personaje)
		personaje.perderVida(10)
	}
	
	override method encuentroEnemigo(cantidad, personaje){
		personaje.perderVida(cantidad)
	}
}

object semiDios inherits Estado{
	
}