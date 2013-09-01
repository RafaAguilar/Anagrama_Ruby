#q = Queue.new
#require 'thread'
require 'parallel'
require 'time'
require 'benchmark'

load("bot.rb")

class Master  

  def initialize(base)
    #numero de bots(CPU)
    @K=4
    #Base es la palabra base para buscar anagramas
    @base=base
    
    #Cargando el diccionario
    #fDicc="alternativo"
	fDicc="diccionario_venezuela"
    dicc=File.open(fDicc)
    @diccL=Array.new
    i=0
    dicc.each do |linea|        # procesamos cada linea como un arreglo
      @diccL[i]=linea.to_s.chomp # almacenamos cada linea quitandole el salto de linea
      i+=1
    end
    dicc.close
    #puts @diccL.class
    #Lock de la consola
    @consola=Mutex.new
    
    #Cola de los bots
    @colaBots=Queue.new
    #@colaBots.push("*")
    #for i in 1..@K
    #  @colaBots.push("*")
    #end
    #Permutar Base
    @permutaciones=@base.split("").permutation.map{|p| p.join("")}
    #puts "original"+@permutaciones.to_s+" largo:"+@permutaciones.length.to_s
    
    #for i in 0..(@K-1)
      #puts "pedazo"+ i.to_s+":"+i*(@permutaciones.length/@K),(i+1)*(@permutaciones.length/@K)).to_s #+" largo:"+@permutaciones.slice(i*(@permutaciones.length/@K),(i+1)*(@permutaciones.length/@K)).length.to_s
    #  puts "i="+i.to_s
    #  puts "K="+@K.to_s
    #  puts "largo="+@permutaciones.length.to_s
    #  puts "X="+(x=(i*(@permutaciones.length/@K))).to_s
    #  puts "Y="+(y=((i+1)*(@permutaciones.length/@K))).to_s
    #  puts "Pedazo="+@permutaciones[x..y].to_s
      #puts i*(@permutaciones.length/@K),(i+1)*(@permutaciones.length/@K)
    #end  
  end

  def iniciar()
    
    
 
    time = Benchmark.realtime do
      
      inicio=Time.new
      puts "iniciar"
      #threads = []
      fin=@K-1
      #for i1 in 0..(fin)
      # #@consola.syncrhonize{ puts "Bot" + i.to_s + ": Saliendo"}
      # i=i1.to_i
      # @consola.synchronize{ puts "Bot" +i.to_s+ " : Saliendo"}
      # #@colaBots.pop()
      # #puts @permutaciones.to_s + ":" + i.to_s + ":" + @K.to_s
       #pedazo=@permutaciones.slice(i*(@permutaciones.length/@K),(i+1)*(@permutaciones.length/@K))
       #puts pedazo 
      # b=Bot.new("Bot" + i.to_s,@diccL,@permutaciones[i*(@permutaciones.length/@K)..(i+1)*(@permutaciones.length/@K)],@colaBots,@consola)
      # threads << Thread.new{b.buscarAlt};
      #end
	  #sputs @diccL
      b=[]
      for i1 in 0..(fin)
        i=i1.to_i;
        #@consola.synchronize{ puts "Bot" +i.to_s+ " : Naciendo"};       
        b[i]= Bot.new("Bot" + i.to_s,@diccL,@permutaciones[i*(@permutaciones.length/@K)..(i+1)*(@permutaciones.length/@K)],@colaBots,@consola)
      end
      
      
      Parallel.map(b) do |bots| 
        #i=i1.to_i;
        #@consola.synchronize{ puts "Bot" +i.to_s+ " : Saliendo"};
         
        #b=Bot.new("Bot" + i.to_s,@diccL,@permutaciones[i*(@permutaciones.length/@K)..(i+1)*(@permutaciones.length/@K)],@colaBots,@consola)
        bots.buscarAlt()
      end
  
      
      #@consola.synchronize{puts "Todos los bots creados"}
      #Thread.new{b[1].buscarAlt()}
      #Thread.new{b[2].buscarAlt()}
      #Thread.new{b[3].buscarAlt()}
      #Thread.new{b[4].buscarAlt()}
      #@consola.synchronize{
      #    puts "Todos los bots despachados"
      #  }
      #for i in 0..(@K-1)
      #  @colaBots.pop()
      #end
      #threads.each {|t| t.join}
      @consola.synchronize{puts "termino";fin =Time.new; puts fin.to_i - inicio.to_i }
    end
    puts (time*1000).to_s
  end
  def getBotS()
    return @colaBots  
  end
  def getConsola()
    return @consola   
  end
  
  def getDiccL()
    return @diccL
  end
end
