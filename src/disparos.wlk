import wollok.game.*
import wollok.game.*
import players.*
import movimientos.*
import enemys.*

class Tirito{
    var property direccion
    var position
    method image() {
        return "cami-der.png"
    }
    method nuevaPosition() = game.onTick(100,"disparo tirito",{direccion.mover(self)})
    method position() = position
    method move(nuevaPosicion){
        position = nuevaPosicion
    }
    method encuentro(player){
    }
    
    method recibeDisparo(param1){}
}

class TiroPlayer inherits Tirito{
	override method image() {
        return "cami-der.png"
    }
	method encuentra(enemigo,tiro){
        game.removeVisual(tiro)
        tirosPlayer.remove(tiro)
        if(tirosPlayer.listaDeDisparos()==0)
        	game.removeTickEvent("disparo tirito")
        enemigo.encuentra(enemigo,tiro)
    }
}

class TiroEnemigo inherits Tirito{
	override method image() {
        return "fran-der.png"
    }
	method encuentra(enemigo,tiro){}
}

//NO REPETIR LOGICA TIROSPLAYER & TIROSENEMIGO
object tirosPlayer{
    var tirito
    const property tiros=[]
    method disparar(){
        tirito=new TiroPlayer(direccion = caro.direccion(), position=caro.position()) 
        	game.addVisual(tirito)
            tirito.nuevaPosition()
            tiros.add(tirito)
            config.colisionDisparoPersonaje()
    }
    method listaDeDisparos()=tiros
    method remove(tiro){tiros.remove(tiro)}
}

object tirosEnemigo{
	var tirito
    const property tirosEnemigo=[]
	method disparar(enemigo){
        tirito=new TiroEnemigo(direccion = enemigo.direccion(), position=enemigo.position()) 
        	game.addVisual(tirito)
            tirito.nuevaPosition()
            tirosEnemigo.add(tirito)
            config.colisionDisparoEnemigo(tirito)
    }
    method listaDeDisparos()=tirosEnemigo
    method remove(tiro){tirosEnemigo.remove(tiro)}
    method desaparecer(disparo){
    	game.removeVisual(disparo)
        tirosEnemigo.remove(disparo)
    }
}
