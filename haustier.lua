quest haustier begin
    state start begin
        --[[FUNKTION(Pet füttern) ANFANG]]--
        function feed()
            say_title("Haustier-Status:")
            say("Momentane Lebenspunkte: "..horse.get_health_pct().."%")
            say("")
            say("Möchtest du dein Haustier füttern?")
            local a = select("Füttern","Abbrechen")
            if a == 1 then
                local food = 50056
                if pc.countitem(food) > 0 then
                    pc.removeitem(food, 1)
                    horse.feed()
                else
                    say("Das Item "..item_name(food).." wird benötiogt.")
                end
            else
                return
            end -- if a(select) ende
        end
        --[[FUNKTION(Pet füttern) ENDE]]--
        
        
        --[[FUNKTION(Tiersprache) ANFANG]]--
        function petlang()
            say_title("Tiersprache erlernen")
            say("Hallo "..pc.get_name()..",")
            say("du kannst die Tiersprache erlernen, indem")
            say("du mir 500kk mitbringst.")
            local y = select("Ich möchte die Tiersprache erlernen","Ich passe")
            if y == 1 then
                if pc.get_gold >= 500000000 then
                    pc.setqf("petlang", 1)
                else
                    local needyang = 500000000-pc.get_gold()
                    syschat("Dir fehlen "..needyang.." Yang")
                end
            else
                return
            end
        end
        --[[FUNKTION(Tiersprache) ENDE]]--
        
        
        --[[FUNKTION(Spielen) ANFANG]]--
        function petplay()
            chat("Du spielst nun mit deinem Haustier.")
            syschat("Du erhälst folgende Boni:")
            chat("Stark gegen Monster - 5% | 5 Minuten lang")
            chat("Stark gegen Halbmenschen - 5% | 5 Minuten lang")
            affect.add_collect(apply.ATT_BONUS_TO_MONSTER, 5, 60*5)
            affect.add_collect(apply.ATTBONUS_HUMAN, 5, 60*5)
        end
        --[[FUNKTION(Spielen) ENDE]]--
        
        
        --[[FUNKTION(Wegschicken) ANFANG]]--
        function away()
            pet.unsummon()
            chat("Dein Haustier wurde fortgeschickt.")
        end
        --[[FUNKTION(Wegschicken) ENDE]]--
        
        
        --[[FUNKTION(Name geben) ANFANG]]--
        function givename()
            if pc.countitem("71110") <= 0 then
                say("Das Item "..item_name("71110").." wird benötigt.")
                say("")
                return
            end -- if pccountitem(futter) ende
            local old_horse_name = horse.get_name() ;
            say_title("Haustiername")
            say("Hier kannst du deinem Haustier einen neuen")
            say("Namen geben. Damit kannst du dein Haustier")
            say("über alle anderen hervorheben.")
            say("")
            if string.len(old_horse_name) == 0 then
                say_reward("Das Haustier besitzt bis jetzt keinen Namen.")
            else
                say_reward("Der momentane Name des Haustieres lautet "..old_horse_name..".")
            end -- if string lenght ende
            say("")
            say("Wähle einen neuen Haustiernamen:")
            say("")
            local horse_name = input()
            if string.len(horse_name) < 2 then
                say_title("Haustiername")
                say("Der Name ist zu kurz.")
                say("")
                return
            elseif string.len(horse_name) > 12 then
                say_title("Haustiername")
                say("Der Name ist zu lang.")
                say("")
                return
            end -- if string.length ende
            local ret = horse.set_name(horse_name)
            say_title("Haustiername")
            if ret == 0 then
                say_reward("Du hast momentan kein Haustier!")
                say("")
            elseif ret == 1 then
                say_reward("Du kannst diesen Namen nicht benutzen!")
                say("")
            elseif ret == 2 then
                pc.remove_item("71110")
                say("Du hast deinem Haustier einen neuen Namen gegeben!")
                say("")
            end -- if ret (haustiername) ende
        end
        --[[FUNKTION(Name geben) ENDE]]--

        
        --[[FUNKTION(Menue) ANFANG]]--
        function pet_menu()
            if horse.is_mine() then
                local s = select("Füttern","Tiersprache","Spielen","Fortschicken","Namen geben","Schließen")
                if s == 1 then
                    haustier.feed()
                elseif s == 2 then
                    haustier.petlang()
                elseif s == 3 then
                    haustier.petplay()
                elseif s == 4 then
                    haustier.away()
                elseif s == 5 then
                    haustier.givename()
                else
                    return
                end -- if s(select) ende
            end -- if horse.is_mine ende
        end -- function petmenue ende
        --[[FUNKTION(Menue) ENDE]]--


        --[[Pet-Menuequest ANFANG]]--
        when 20120.click or 20121.click or 20122.click or 20123.click or
             20124.click or 20125.click or 20126.click or 20127.click or
             20128.click or 20129.click or 20130.click or 20131.click or
             20132.click or 20133.click or 20133.click or 20134.click or
             20135.click or 20136.click or 20137.click or 20138.click or
              20139.click or 20140.click or 20141.click or 20142.click or
             20143.click begin haustier.pet_menu() end
        --[[Pet-Menuequest ENDE]]--
        
        --[[Pet-Rufquest ANFANG]]--
        when 53001.use or 53002.use or 53003.use or
             53005.use or 53006.use or 53007.use or
             53008.use or 53009.use begin


            --[[Petlevel - Item ANFANG]]--
            local levels = {
                [53001] = {22},
                [53003] = {23},
                [53002] = {24},
                [53005] = {25},
                [53006] = {27},
                [53007] = {28},
                [53008] = {29},
                [53009] = {29},
            }
            --[[Petlevel - Item ENDE]]--


            horse.set_level(levels[item.get_vnum()][1])
            pet.summon()
            syschat("Dein Haustier wurde gerufen!")


        --[[Pet-Rufquest ENDE]]--


    end -- state start - ende
end -- quest ende