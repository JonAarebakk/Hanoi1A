use context essentials2021
include shared-gdrive("dcic-2021", "1wyQZj_L0qqV9Ekgr9au6RX2iqt2Ga8Ep")
include image
include lists


pinne = circle(8, "solid", "black")
#1 - den minste
s1 = overlay(pinne, circle(25, "solid", "red"))
#2 - den nest minste
s2 = overlay(pinne, circle(40, "solid", "green"))
#3 - den nest største
s3 = overlay(pinne, circle(55, "solid", "blue"))
#4 - den største
s4 = overlay(pinne, circle(70, "solid", "orange"))
#"pinnen"

pinne2 = overlay(pinne, circle(100, "solid", "transparent"))
bakgrunn = beside(pinne2, beside(pinne2, pinne2))
ramme = (overlay-align("left", "middle", bakgrunn, rectangle(600, 200, "solid", "white")))

#lager en tabell som setter x-koordinatene til brikkene
hanoi-coordinates =
  table: brikke1, brikke2, brikke3, brikke4
    row: -75, -60, -45, -30
    row: -275, -260, -245, -230
    row: -475, -460, -445, -430
  end

#Navngi pins med info om brikkene inni
var brikker = [list: 1, 1, 1, 1]

var trekk = 0

#Setter startverdiene for x for alle brikkene
var xs1 = hanoi-coordinates.row-n(0)["brikke1"]
var xs2 = hanoi-coordinates.row-n(0)["brikke2"]
var xs3 = hanoi-coordinates.row-n(0)["brikke3"]
var xs4 = hanoi-coordinates.row-n(0)["brikke4"]


#Starter et nytt spill med ting satt til startverdier
fun new-game():
  block:
    brikker := [list: 1, 1, 1, 1]
    xs1 := hanoi-coordinates.row-n(0)["brikke1"]
    xs2 := hanoi-coordinates.row-n(0)["brikke2"] 
    xs3 := hanoi-coordinates.row-n(0)["brikke3"]
    xs4 := hanoi-coordinates.row-n(0)["brikke4"]
    trekk := 0
    tegn-brett()
  end
end


#Flytter brikkene innad i lista
fun move(fra :: Number, til :: Number):
  if (num-max(fra, til) > 3) or (num-min(fra, til) < 1): 
    "Ugyldig trekk, venligst velg bruk en verdi mellom 1-3"
  else: 
    fra-stang = finn-brikke(fra, 0)
    til-stang = finn-brikke(til, 0)
    if fra-stang == 4:
        "Ugyldig trekk"
    else if fra-stang < til-stang:
      block:  
        brikker := brikker.set(fra-stang, til)
        trekk := trekk + 1 
        temp = vinn-sjekk()
        print(temp)
        tegn-brett()
        end
      else: 
        "Ugyldig trekk"
    
    end 
  end
end
  


# Kjører igjennom funksjonen fram til den finner den første brikken som befinner seg på riktige stang.
fun finn-brikke(pos :: Number, index :: Number):
    if (index > 3) or (brikker.get(index) == pos):
      index
  else:
    finn-brikke(pos, index + 1)
  end
end

# Setter x-verdiene til de forskjellige brikkene
fun koordinater():
  block:
    xs1 := hanoi-coordinates.row-n(brikker.get(0) - 1)["brikke1"]
    xs2 := hanoi-coordinates.row-n(brikker.get(1) - 1)["brikke2"]
    xs3 := hanoi-coordinates.row-n(brikker.get(2) - 1)["brikke3"]
    xs4 := hanoi-coordinates.row-n(brikker.get(3) - 1)["brikke4"]
  end  
end

#Tegner spillebrettet
fun tegn-brett():
  block:
    koordinater()
    overlay-xy(s1, xs1, -75, 
      overlay-xy(s2, xs2, -60, 
        overlay-xy(s3, xs3, -45, 
          overlay-xy(s4, xs4, -30, 
          frame(overlay-align("left", "middle", bakgrunn, rectangle(600, 200, "solid", "white")))))))
  end
end


#Sjekker om spillet er vunnet
fun vinn-sjekk():
 var print-trekk = num-to-string(trekk)
 if brikker == [list: 3, 3, 3, 3]:
    "Gratulerer, du har vunnet på " + print-trekk + " trekk!"
  else:
    "Du har brukt " + print-trekk + " trekk"
end
end


tegn-brett()
"For å starte spillet, bruk move(fra, til), hvor første" 
"verdien er stangen du ønsker og flytte en brikke ifra,"
"og den andre verdien er destinasjonen til brikken"
