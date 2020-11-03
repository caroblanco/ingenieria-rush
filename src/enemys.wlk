import wollok.game.*
import players.*
import movimientos.*
import disparos.*
import pantallaInicio.*

class Feind{ //enemigo aber auf Deutsch
    var property position
    var direccion = izquierda
    var impactos
    
    method direccion() = direccion
    
    method nuevaDireccion(nuevaD){
        direccion=nuevaD
    }
       
    method ataque()=0
    
    method move(nuevaPosicion){
        position = nuevaPosicion
    }
	
	
	//RESPONSABILIDAD DEL ELEVATOR
    method enElElevator(){
        return (self.position().x().between(10,13))
    }
    method encuentro(jugador){
        game.onTick(800, "perder vida", {jugador.perderVida(self.ataque())}) 
        self.evaluador()
    }

    method evaluador(){
        game.onTick(800,"misma pos", {if(self.position() != personajeSeleccionado.personaje().position()) self.sacartick()})
    }

    method sacartick(){
        game.removeTickEvent("perder vida") 
        game.removeTickEvent("misma pos")
    }

    method impactos() = impactos

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

    method restarImp(){
        impactos-=1
    }
    
    method disparar(){
        if(self.position().y() == personajeSeleccionado.personaje().position().y()){
        	tirosEnemigo.disparar(self)
        }
    }
}

class FeindSimple inherits Feind{

    method image() {
        return "pinieiro.png"
    }
    override method ataque() = 5
    override method disparar(){}
}

class FeindDispara inherits Feind{

    method image() {
        return "vanos.png"
    }
    override method ataque() = 10

    /*override method disparar(){
        if(self.position().y() == personajeSeleccionado.personaje().position().y()){
        	tirosEnemigo.disparar(self)
        }
    }*/
}

class FeindPapota inherits FeindDispara{

    override method image() {
        return "enemy.png"
    }
    override method ataque() = 15

   /*  override method disparar(){
        if(self.position().y() == personajeSeleccionado.personaje().position().y()){
        	tirosEnemigo.disparar(self)
        }
    }*/
}

///////////////////////////////////////////////////////////////////

object enemigos{
    var enemigo
    const property listaEnemigos=[]
    const property listaEnemigosDisparo=[]
    const puertas = [2,6,16,20]
    var pos
	
    method aparecerEnemigos(){
        game.onTick(8000,"nuevo enemigo que dispara",{
        	
            enemigo=new FeindDispara(impactos = 1,position= game.at(self.generarPuerta(), 4), direccion = derecha)
            self.nuevoEnemigo()                 												// a caro no le gusta esto, cami lo secunda
            listaEnemigosDisparo.add(enemigo)                                                	// a caro no le  gusta esto
            if (listaEnemigosDisparo.size() == 1)
                activador.ontick() 
            if (listaEnemigos.size()==1)		//se repite
                activador.perseguirAPlayer()
        }) 
        
        game.onTick(5000,"nuevo enemigo simple",{
        	
            enemigo=new FeindSimple(impactos = 0,position= game.at(self.generarPuerta(), 0))
            self.nuevoEnemigo()
            if (listaEnemigos.size()==1)		//se repite
                activador.perseguirAPlayer()
        })
        
        game.onTick(10000,"nuevo enemigo papota",{
        	enemigo = new FeindPapota(impactos = 5, position = game.at(self.generarPuerta(),8))
        	self.nuevoEnemigo()
        	listaEnemigosDisparo.add(enemigo)                                                	// a caro no le  gusta esto
            if (listaEnemigosDisparo.size() == 1)
                activador.ontick() 
            if (listaEnemigos.size()==1)		//se repite
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

