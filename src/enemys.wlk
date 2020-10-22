import wollok.game.*
import players.*
import movimientos.*
import disparos.*

class Feind{ //enemigo aber auf Deutch
    //var property movimiento
    var property position
    //var property direccion
    method ataque()=0
    method move(nuevaPosicion){
        position = nuevaPosicion
    }

    method enElElevator(){
        return (self.position().x().between(10,13))
    }
    method encuentro(jugador){
        game.onTick(800, "perder vida", {jugador.perderVida(self.ataque())}) 
        game.say(jugador,"me esta matando el coloquio de discreta")
        self.evaluador()
    }

    method evaluador(){
        game.onTick(800,"misma pos", {if(self.position() != caro.position()) self.sacartick()})
    }

    method sacartick(){
        game.removeTickEvent("perder vida") 
        game.removeTickEvent("misma pos")
    }

    method impactos()

    method encuentra(enemigo,tiro){
        if(enemigo.impactos() == 0){
            	game.removeVisual(enemigo)

                if(enemigos.listaEnemigos().size()==1)
                    game.removeTickEvent("perseguir player")
                enemigos.listaEnemigos().remove(enemigo)
       
                if(enemigos.listaEnemigosDisparo().contains(enemigo)){
                  		if(enemigos.listaEnemigosDisparo().size()==1)
                    		game.removeTickEvent("disparo enemigo")
                  	 	enemigos.listaEnemigosDisparo().remove(enemigo)
                }

        }else{
            enemigo.restarImp()
        }
    }
    method recibeDisparo(disparo){
    }

    method restarImp()
    method disparar()
}

class FeindSimple inherits Feind{
    var property impactos = 0
    override method restarImp(){
        impactos-=1
    }

    method image() {
        return "pinieiro.png"
    }
    override method ataque() = 5 //cambiar nombre a "cant"
    override method disparar(){}
}

class FeindDispara inherits Feind{
    var property direccion
    var property impactos = 1
    method image() {
        return "vanos.png"
    }
    override method ataque() = 10

    override method restarImp(){
        impactos-=1
    }
    override method disparar(){
        if(self.position().y() == caro.position().y()){
        	tirosEnemigo.disparar(self)
        }
    }
}

object enemigos{
    var enemigo
    const property listaEnemigos=[]
    const property listaEnemigosDisparo=[]
    const puertas = [2,6,16,20]
    var pos
	
    method aparecerEnemigos(){
        game.onTick(8000,"nuevo enemigo que dispara",{
        	
            enemigo=new FeindDispara(position= game.at(self.generarPuerta(), 4), direccion = derecha)
            self.nuevoEnemigo()                 												// a caro no le gusta esto, cami lo secunda
            listaEnemigosDisparo.add(enemigo)                                                	// a caro no le  gusta esto
            if (listaEnemigosDisparo.size() == 1)
                activador.ontick() 
            if (listaEnemigos.size()==1)
                activador.perseguirAPlayer()
        }) 
        game.onTick(5000,"nuevo enemigo simple",{
        	
            enemigo=new FeindSimple(position= game.at(self.generarPuerta(), 0))
            self.nuevoEnemigo()
            if (listaEnemigos.size()==1)
                activador.perseguirAPlayer()
        })
    }
    method enemigo()= enemigo
    
    method generarPuerta(){
    	pos = 0.randomUpTo(4)
        return puertas.get(pos)
    }
    
    method nuevoEnemigo(){
        game.addVisual(enemigo)
        listaEnemigos.add(enemigo)
    }
}
