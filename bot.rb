class Bot
  def initialize(nombre,diccL,intentos,termine,consola)
    @nombre,@diccL,@intentos,@termine,@consola=nombre,diccL,intentos,termine,consola
    #@consola.synchronize{puts @intentos}
  end
  
  def buscarAlt()
    #@consola.synchronize{puts @diccL.to_s}
    #@consola.synchronize{puts @intentos.to_s}
    for intento in @intentos
      #@consola.synchronize{puts @nombre+":"+intento.class.to_s}
      for palabra in @diccL
		#@consola.synchronize{puts @nombre+":"+palabra.class.to_s+"\n "}        
        #@consola.synchronize{puts @nombre+":"+palabra+":"+intento}        
        if palabra==intento
          @consola.synchronize{puts "\n============Anagrama-> " + @nombre+":"+palabra}
		  #palabra = nil			
        end
		#intento = nil
      end
    end
    #@consola.synchronize{puts @nombre + ": Finalize"}
    #@termine.push("*")
  end
  
  def limpiarIntento()
    return nil
  end
end
