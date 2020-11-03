import wollok.game.*
import players.*
import movimientos.*
import enemys.*
import pantallaInicio.*

class Tirito{ //fwmemefejfio
    var property direccion
    var position
    method position() = position
    method move(nuevaPosicion){
        position = nuevaPosicion
    }
    method encuentro(player){
    }

    method recibeDisparo(param1){}

    method enPantalla() = self.position().x() > 0 || self.position().y() < game.width()
}

class TiroEnemigo inherits Tirito{
    method image() {
        return "fran-der.png"
    }

    method encuentra(enemigo,tiro){}
    
    method remove(){
    	tirosEnemigo.desaparecer(self)
    }
}

class TiroPlayer inherits Tirito{
    method encuentra(enemigo,tiro){
        tirosPlayer.desaparecer(tiro)
        enemigo.encuentra(enemigo,tiro)
    }
    method image(){
        return personajeSeleccionado.personaje().disparo()
    }
    
    method remove(){
    	tirosPlayer.desaparecer(self)
    }
}

///////////////////////////////////////////////////////////////////

object tirosPlayer{
    var tirito
    const property tiros=[]
    method disparar(){
    	if(personajeSeleccionado.personaje().vivo()){
    		tirito=new TiroPlayer(direccion = personajeSeleccionado.personaje().direccion(), position=personajeSeleccionado.personaje().position()) 
            game.addVisual(tirito)
            tiros.add(tirito)
            config.colisionDisparoPersonaje()
    	}
    }

    method listaDeDisparos()=tiros
    method desaparecer(disparo){ //holis
        game.removeVisual(disparo)
        tiros.remove(disparo)
    }
    method nuevaPosition() = game.onTick(100,"movimiento tiros player",{tiros.forEach({tiro =>tiro.direccion().mover(tiro)})})
}

object tirosEnemigo{
    var tirito
    const property tirosEnemigo=[]
    method disparar(enemigo){
        tirito=new TiroEnemigo(direccion = enemigo.direccion(), position=enemigo.position()) 
            game.addVisual(tirito)
            tirosEnemigo.add(tirito)
            config.colisionDisparoEnemigo(tirito)
    }
    method listaDeDisparos()=tirosEnemigo
    method desaparecer(disparo){
        game.removeVisual(disparo)
        tirosEnemigo.remove(disparo)
    }
    method nuevaPosition() = game.onTick(100,"movimiento tiros enemgio",{tirosEnemigo.forEach({tiro =>tiro.direccion().mover(tiro)})})
}
