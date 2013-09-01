    require 'parallel'
    require 'time'
    require 'benchmark'

    class Bot
      def initialize(nombre,diccL,intentos,termine,consola)
        @nombre,@diccL,@intentos,@termine,@consola=nombre,diccL,intentos,termine,consola
      end
      
      def buscarAlt()
        for intento in @intentos
          for palabra in @diccL
            if palabra[1]==intento
              @consola.synchronize{puts "\n============Anagrama-> " + @nombre+":"+palabra[1]}
              palabra = nil            
            end
            intento = nil
          end
        end
      end
    end

    class Master  

      def initialize(base)
        #number of bots(CPU cores)
        @K=4
        #Base is the keyword to find the anagrama
        @base=base
        
        #Loading Dict
        fDicc="alternativo"
        dicc=File.open(fDicc)
        @diccL=Hash.new
        i=0
        dicc.each do |linea|        
          @diccL[i]=linea.to_s.chomp
          i+=1
        end
        dicc.close

        @consola=Mutex.new
        

        @colaBots=Queue.new

        @permutaciones=@base.split("").permutation.map{|p| p.join("")}
        
      end

      def iniciar()
        
        
     
        time = Benchmark.realtime do
          
          inicio=Time.new
          puts "iniciar"

          fin=@K-1
          b=[]
          for i1 in 0..(fin)
            i=i1.to_i;
            b[i]= Bot.new("Bot" + i.to_s,@diccL,@permutaciones[i*(@permutaciones.length/@K)..(i+1)*(@permutaciones.length/@K)],@colaBots,@consola)
          end
          
          
          Parallel.map(b) do |bots| 
            bots.buscarAlt()
          end
          @consola.synchronize{puts "termino";fin =Time.new; puts fin.to_i - inicio.to_i }
        end
        puts (time*1000).to_s
      end  
    end
