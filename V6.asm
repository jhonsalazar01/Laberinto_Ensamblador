org 100h

    ;modo texto de 80*25
    mov al,0 
    mov ah,0
    int 10h
               
call instruccion                  
call printBarras 
call printBarrasbb
call nombres             
call printGame 
call borrarinstruccion                                  
call reinicio   


    
leerTecla:
    ;esperando a leer la tecla
    mov ah,0 
    int 16h       
    ;mov fila2,fila
    mov dl,fila
    mov filAnt,dl
    mov dl,columna
    mov colAnt,dl
    
    ;lee tecla derecha
    cmp al,064h ;d
    je derecha
    
    ;lee tecla abajo
    cmp al,073h ;s
    je abajo
    
    ;lee tecla izquierda
    cmp al,061h ;a
    je izquierda
    
    ;lee tecla arriba
    cmp al,077h ;w
    je arriba
    
    ;reiniciar juegador
    cmp al,72h
    je reinicio
    
    ;control tecla errada    
    jmp error
    
error:; salta si es tecla errada
    jmp leerTecla       
    
    
derecha:  
    inc columna
    mov bh,0
    mov dh,fila
    mov dl,columna  
    
    mov ah, 02h
    int 10h
     
    mov ah, 08h
    int 10h
   
    cmp ah,0fh 
    jne der  
    jmp printPlayer 
         
    der:
        dec columna   
        mov bh,0
        mov dh,fila
        mov dl,columna  
    
        mov ah, 02h
        int 10h
        jmp leerTecla 
    

izquierda:  

    
    dec columna
    mov bh,0
    mov dh,fila
    mov dl,columna  
    
    mov ah, 02h
    int 10h
     
    mov ah, 08h
    int 10h
   
    cmp ah,0fh 
    jne izq  
    jmp printPlayer 
         
        izq:
            inc columna   
            mov bh,0
            mov dh,fila
            mov dl,columna  
    
            mov ah, 02h
            int 10h
            jmp leerTecla 
    
    
arriba:
      
    dec fila   
    mov bh,0
    mov dh,fila
    mov dl,columna  
    
    mov ah, 02h
    int 10h
     
    mov ah, 08h
    int 10h

    cmp ah,0fh 
    jne arb  
    jmp printPlayer 
         
    arb:
        inc fila   
        mov bh,0
        mov dh,fila
        mov dl,columna  
    
        mov ah, 02h
        int 10h
        jmp leerTecla 
      
    
abajo:  
 
    inc fila   
    mov bh,0
    mov dh,fila
    mov dl,columna  
    mov ah, 02h
    int 10h
    mov ah, 08h
    int 10h  
    cmp ah,0ah  
     
    je printPlayer  
    cmp ah,0fh  
    jne abj  
    jmp printPlayer 
         
    abj:
        dec fila   
        mov bh,0
        mov dh,fila
        mov dl,columna  
        mov ah, 02h
        int 10h
        jmp leerTecla 
 

      
ret

 ;fin de la app
;:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::


verificarWin:
    cmp fila,22
    je verifCol
    jmp finverif 
    
verifCol:
    cmp columna,21
    je  Win

finverif:    
ret  




reinicio:
     
    mov fila,2    
    mov columna,3
    
    
    ;repinta el jugador
    mov dh,fila
    mov dl,columna
    mov bh,0
    mov ah,2
    int 10h
    je  printPlayer
ret    





posInicial:
    
    ;mueve el cursor a la posicion anterior   
    mov dh,filAnt
    mov dl,colAnt
    mov bh,0
    mov ah,2
    int 10h
     
    ;valida si esta en columna 0 
    cmp dl,2
    je finPintar
    ;valida si esta en el punto inicial
    cmp dh,2
    je pintarInicial 
    ;pinta el carater 0FEh
    mov al,0DBh
    mov bh,0
    mov bl,0fh
    mov cx,1
    
    mov ah,09h
    int 10h
    jmp finPintar  
    
    
    
    
pintarInicial:
    ;pinta el carater 0FEh
    mov al,0DBh
    mov bh,0
    mov bl,0Ch
    mov cx,1
    
    mov ah,09h
    int 10h
    
    jmp finPintar 
      
    
finPintar:
ret
         
         
         
         
         
printPlayer:
    
    call posInicial
    call verificarWin
    ;repinta el jugador
    mov dh,fila
    mov dl,columna
    mov bh,0
    mov ah,2
    int 10h
    
    ;cmp dh,1
    ;je printInicio
    
    ;pinta el carater 015
    mov al,02Ah
    mov bh,0
    mov bl,03ah
    mov cx,1
    
    mov ah,09h
    int 10h

    jmp leerTecla
ret     
     
     
     
   

Win: ;muestra el mensaje de ganador
    mov filAnt,2
    mov colAnt,2
    
    ;coordenadas ubicacion mensaje 
    mov dh,14
    mov dl,25
    mov bh,0
    mov ah,2
    int 10h
    
    mov bx,offset mensajeGanaste1
    call printMsj
    
    mov dh,15
    mov dl,25
    mov bh,0
    mov ah,2
    int 10h
    
    mov bx,offset mensajeGanaste2
    call printMsj
    
    mov dh,16
    mov dl,25
    mov bh,0
    mov ah,2
    int 10h
    
    mov bx,offset mensajeGanaste3
    call printMsj
    
    mov dh,18
    mov dl,25
    mov bh,0
    mov ah,2
    int 10h
    
    mov bx,offset mensajeRinicio1
    call printMsj 
    
    mov dh,20
    mov dl,25
    mov bh,0
    mov ah,2
    int 10h
    
    mov bx,offset mensajeRinicio2
    call printMsj 
    
    mov dh,21
    mov dl,25
    mov bh,0
    mov ah,2
    int 10h
    
    mov bx,offset mensajeRinicio3
    call printMsj  
    
    jmp main


;-------------------------------------------------------
printMsj:;imprime un mensaje segun bx     
   cmp [bx],0
    je  finMsj
    mov al,[bx]
    mov ah,0eh
    int 10h
    add bx,1
    jmp printMsj
finMsj:    
ret


    
    
    
    
    
    
    
    
 nombres: ;muestra el mensaje de autores
    mov filAnt,2
    mov colAnt,2
    
    ;coordenadas ubicacion mensaje 
    mov dh,4
    mov dl,23
    mov bh,0
    mov ah,2
    int 10h
    
    mov bx,offset one
    call printMsja
    
    mov dh,5
    mov dl,23
    mov bh,0
    mov ah,2
    int 10h
    
    mov bx,offset onea
    call printMsja
    
    mov dh,8
    mov dl,23
    mov bh,0
    mov ah,2
    int 10h
    
    mov bx,offset two
    call printMsja
    
    mov dh,9
    mov dl,23
    mov bh,0
    mov ah,2
    int 10h
    
    mov bx,offset twoa
    call printMsja 
    
    mov dh,21
    mov dl,23
    mov bh,0
    mov ah,2
    int 10h
    


;-------------------------------------------------------
printMsja:;imprime un mensaje segun bx     
   cmp [bx],0
    je  finMsj
    mov al,[bx]
    mov ah,0eh
    int 10h
    add bx,1
    jmp printMsja
finMsja:    
ret    
    
    
    
    
    


;:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::


instruccion: ;muestra el mensaje de autores
  
    
    ;coordenadas ubicacion mensaje 
    mov dh,14
    mov dl,24
    mov bh,0
    mov ah,2
    int 10h
    
    mov bx,offset in1
    call printMsji
    
    mov dh,15
    mov dl,24
    mov bh,0
    mov ah,2
    int 10h
    
    mov bx,offset in2
    call printMsji
    
    mov dh,16
    mov dl,24
    mov bh,0
    mov ah,2
    int 10h
    
    mov bx,offset in1
    call printMsji
    
    mov dh,17
    mov dl,24
    mov bh,0
    mov ah,2
    int 10h
    
    mov bx,offset in3
    call printMsji 
    
    mov dh,18
    mov dl,24
    mov bh,0
    mov ah,2
    int 10h
              
    mov bx,offset in4
    call printMsji 
    
    mov dh,19
    mov dl,24
    mov bh,0
    mov ah,2
    int 10h  
    
    mov bx,offset in5
    call printMsji 
    
    mov dh,20
    mov dl,24
    mov bh,0
    mov ah,2
    int 10h
              
    mov bx,offset in6
    call printMsji 
    
    mov dh,21
    mov dl,24
    mov bh,0
    mov ah,2
    int 10h      
    
    
    mov bx,offset in7
    call printMsji 
    
    mov dh,22
    mov dl,24
    mov bh,0
    mov ah,2
    int 10h   
    
    mov bx,offset in1
    call printMsji 
ret            



borrarinstruccion: ;muestra el mensaje de autores
  
    
    ;coordenadas ubicacion mensaje 
    mov dh,14
    mov dl,24
    mov bh,0
    mov ah,2
    int 10h
    
    mov bx,offset mensajeNulo
    call printMsj
    
    mov dh,15
    mov dl,24
    mov bh,0
    mov ah,2
    int 10h
    
    mov bx,offset mensajeNulo
    call printMsj
    
    mov dh,16
    mov dl,24
    mov bh,0
    mov ah,2
    int 10h
    
    mov bx,offset mensajeNulo
    call printMsj
    
    mov dh,17
    mov dl,24
    mov bh,0
    mov ah,2
    int 10h
    
    mov bx,offset mensajeNulo
    call printMsj
    
    mov dh,18
    mov dl,24
    mov bh,0
    mov ah,2
    int 10h
              
    mov bx,offset mensajeNulo
    call printMsj 
    
    mov dh,19
    mov dl,24
    mov bh,0
    mov ah,2
    int 10h  
    
    mov bx,offset mensajeNulo
    call printMsj 
    
    mov dh,20
    mov dl,24
    mov bh,0
    mov ah,2
    int 10h
              
    mov bx,offset mensajeNulo
    call printMsj 
    
    mov dh,21
    mov dl,24
    mov bh,0
    mov ah,2
    int 10h      
    
    
    mov bx,offset mensajeNulo
    call printMsj 
    
    mov dh,22
    mov dl,24
    mov bh,0
    mov ah,2
    int 10h   
    
    mov bx,offset mensajeNulo
    call printMsj 
ret


;-------------------------------------------------------
printMsji:;imprime un mensaje segun bx     
   cmp [bx],0
    je  finMsj
    mov al,[bx]
    mov ah,0eh
    int 10h
    add bx,1
    jmp printMsji
finMsji:    
ret    
    
;-------------------------------------------------------
    
main: 
       
    mov dh,23
    mov dl,25
    mov bh,0
    mov ah,2
    int 10h   
       
    mov ah,0 
    int 16h 

    cmp al,031h ;1
    je ac1
    
     cmp al,032h ;2
    je ac2  
    
    jmp main   
    

ac1:  
    mov fila,2
    mov filAnt,2
     call borrarMenu
    mov columna,3
    mov colAnt,2
    
    ;repinta el jugador
    mov dh,fila
    mov dl,columna
    mov bh,0
    mov ah,2
    int 10h
    je  printPlayer
   
    jmp reinicio:  
ret

ac2: 
    jmp fin 
  


;-------------------------------------------------------

borrarMenu:
    ;coordenadas ubicacion mensaje 
    mov dh,14
    mov dl,25
    mov bh,0
    mov ah,2
    int 10h
    
    mov bx,offset mensajeNulo
    call printMsj
    
    mov dh,15
    mov dl,25
    mov bh,0
    mov ah,2
    int 10h
    
    mov bx,offset mensajeNulo
    call printMsj
    
    mov dh,16
    mov dl,25
    mov bh,0
    mov ah,2
    int 10h
    
    mov bx,offset mensajeNulo
    call printMsj
    
    mov dh,18
    mov dl,25
    mov bh,0
    mov ah,2
    int 10h
    
    mov bx,offset mensajeNulo
    call printMsj 
    
    mov dh,20
    mov dl,25
    mov bh,0
    mov ah,2
    int 10h
    
    mov bx,offset mensajeNulo
    call printMsj 
    
    mov dh,21
    mov dl,25
    mov bh,0
    mov ah,2
    int 10h
    
    mov bx,offset mensajeNulo
    call printMsj  
   
ret

;-------------------------------------------------------
      
printMeta:
    
    mov dh,22
    mov dl,21
    mov bh,0
    mov ah,2
    int 10h
    
    ;pinta el carater 0FEh
    mov al,0DBh
    mov bh,0
    mov bl,0Ah
    mov cx,1
    
    mov ah,09h
    int 10h  
    call leerTecla
          
ret

;-------------------------------------------------------

printGame:
    mov bx,offset colorLaberinto
    mov dirColor,bx

pcol:
    cmp columna,23
    je pfil
    call printPixel
    inc columna
    jmp pcol
pfil:
    cmp fila,22
    je  finPG
    inc fila
    mov columna,2
    jmp pcol 
    
finPG:                 
ret

;-------------------------------------------------------
    
    
printPixel:
    ;ubicar el cursor en pantalla
    mov dl,columna
    mov dh,fila
    mov bh,0 ;numero de pagina
    mov ah,2
    int 10h   
    ;asignar color          
    mov bx, dirColor
    mov al,[bx]
    mov color,al
    inc dirColor
    
    mov al,[bx] 
    mov color,al
    ;imprimir caracter 
    mov al,219
    mov bh,0
    mov bl,color
    mov cx,1
    mov ah,09h
    int 10h

ret 

;::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::.

printBarras:
    mov bx, offset colorba
    mov dirColor, bx

pcolba:
    cmp columnaba, 38     
    je finPGba           
    call printPixelba    
    inc columnaba        
    jmp pcolba           

pfilba:
    cmp filaba, 1        
    je finPGba           
    inc filaba           
    mov columnaba, 30    
    jmp pcolba          

finPGba:
    ret

printPixelba:
    ; Ubicar el cursor en pantalla
    mov dl, columnaba    
    mov dh, filaba        
    mov bh, 0          
    mov ah, 2          
    int 10h            

    ; Asignar color
    mov bx, dirColor 
    mov al, [bx]        
    mov color, al       
    inc dirColor        

    ; Imprimir caracter
    mov al, 219        
    mov bh, 0          
    mov bl, color      
    mov cx, 1          
    mov ah, 09h        
    int 10h            

    ret

;:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

printBarrasbb:
    mov bx, offset colorbb
    mov dirColor, bx

pcolbb:
    cmp columnabb, 38    
    je finPGbb            
    call printPixelbb    
    inc columnabb       
    jmp pcolbb           

pfilbb:
    cmp filabb, 1        
    je finPGbb            
    inc filabb           
    mov columnabb, 30     
    jmp pcolbb           

finPGbb:
    ret

printPixelbb:
    ; Ubicar el cursor en pantalla
    mov dl, columnabb     
    mov dh, filabb      
    mov bh, 0            
    mov ah, 2             
    int 10h              

    ; Asignar color
    mov bx, dirColor     
    mov al, [bx]        
    mov color, al        
    inc dirColor        

    ; Imprimir caracter
    mov al, 219           
    mov bh, 0            
    mov bl, color        
    mov cx, 1            
    mov ah, 09h           
    int 10h               

    ret


fin:



fila     db 2
columna  db 2
filAnt   db 2
colAnt   db 2
dirColor dw 0
color    db 0   

mensajeGanaste1 db '+----------+',0
mensajeGanaste2 db '|¡Ganaste!$|',0  
mensajeGanaste3 db '+----------+',0 
mensajeNulo     db '              ',0

mensajeRinicio1 db '    pulse   ',0
mensajeRinicio2 db '1. Reiniciar',0
mensajeRinicio3 db '2. Salir    ',0             

one             db '  Jhon Salazar',0    
onea            db '  201710106   ',0  

two             db '  Jhon Jaime  ',0    
twoa            db '  201711735   ',0   

         


in1 db '+------------+',0
in2 db '|¿Como mover?|',0    

in3 db '|w->Arriba   |',0
in4 db '|a->Izquierda|',0    
in5 db '|s->Abajo    |',0    
in6 db '|d->Derecha  |',0
in7 db '|r->Reiniciar|',0
                       
                               
                               
                   ;1   2   3   4   5   6   7   8   9   10  11  12  13  14  15  16  17  18  19  20  21
colorLaberinto:   db 01h,0Ch,01h,01h,01h,01h,01h,01h,01h,01h,01h,01h,01h,01h,01h,01h,01h,01h,01h,01h,01h
                  db 01h,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,01h,0fh,0fh,0fh,01h,0fh,01h
                  db 01h,0fh,01h,01h,01h,01h,01h,01h,01h,01h,01h,01h,01h,0fh,01h,0fh,01h,0fh,01h,0fh,01h
                  db 01h,0fh,0fh,0fh,0fh,0fh,01h,0fh,01h,0fh,0fh,0fh,01h,0fh,01h,0fh,01h,0fh,01h,0fh,01h
                  db 01h,01h,01h,01h,01h,0fh,01h,0fh,01h,0fh,01h,0fh,01h,0fh,01h,0fh,01h,0fh,01h,0fh,01h
                  db 01h,0fh,0fh,0fh,0fh,0fh,01h,0fh,01h,0fh,01h,0fh,0fh,0fh,01h,0fh,01h,0fh,0fh,0fh,01h
                  db 01h,0fh,01h,01h,01h,01h,01h,0fh,01h,0fh,01h,01h,01h,0fh,01h,0fh,01h,01h,01h,0fh,01h
                  db 01h,0fh,0fh,0fh,0fh,0fh,0fh,0fh,01h,0fh,0fh,0fh,01h,0fh,01h,0fh,01h,0fh,0fh,0fh,01h
                  db 01h,01h,01h,01h,01h,01h,01h,0fh,01h,01h,01h,0fh,01h,01h,01h,0fh,01h,01h,01h,0fh,01h
                  db 01h,0fh,0fh,0fh,0fh,0fh,01h,0fh,0fh,0fh,01h,0fh,0fh,0fh,01h,0fh,0fh,0fh,01h,0fh,01h
                  db 01h,0fh,01h,01h,01h,0fh,01h,0fh,01h,01h,01h,01h,01h,0fh,01h,01h,01h,01h,01h,0fh,01h
                  db 01h,0fh,01h,0fh,0fh,0fh,01h,0fh,01h,0fh,0fh,0fh,01h,0fh,0fh,0fh,01h,0fh,0fh,0fh,01h
                  db 01h,0fh,01h,0fh,01h,01h,01h,01h,01h,0fh,01h,0fh,01h,01h,01h,0fh,01h,0fh,01h,01h,01h
                  db 01h,0fh,01h,0fh,0fh,0fh,0fh,0fh,01h,0fh,01h,0fh,0fh,0fh,0fh,0fh,01h,0fh,0fh,0fh,01h
                  db 01h,0fh,01h,01h,01h,01h,01h,0fh,01h,0fh,01h,01h,01h,01h,01h,01h,01h,01h,01h,0fh,01h
                  db 01h,0fh,01h,0fh,0fh,0fh,01h,0fh,01h,0fh,0fh,0fh,01h,0fh,0fh,0fh,0fh,0fh,0fh,0fh,01h
                  db 01h,0fh,01h,0fh,01h,0fh,01h,0fh,01h,01h,01h,0fh,01h,0fh,01h,01h,01h,01h,01h,01h,01h
                  db 01h,0fh,01h,0fh,01h,0fh,0fh,0fh,0fh,0fh,0fh,0fh,01h,0fh,01h,0fh,0fh,0fh,0fh,0fh,01h
                  db 01h,0fh,01h,01h,01h,01h,01h,01h,01h,01h,01h,01h,01h,0fh,01h,0fh,01h,01h,01h,0fh,01h
                  db 01h,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,01h,0fh,0fh,0fh,01h
                  db 01h,01h,01h,01h,01h,01h,01h,01h,01h,01h,01h,01h,01h,01h,01h,01h,01h,01h,01h,0ah,01h,
        
filaba        db 2   
columnaba     db 24  
colorba       db 0ah,0ah,0ah,0ah,0ah,0ah,0ah,0ah,0ah,0ah,0ah,0ah,0ah,0ah,0ah,

filabb        db 12   
columnabb     db 24  
colorbb       db 0ah,0ah,0ah,0ah,0ah,0ah,0ah,0ah,0ah,0ah,0ah,0ah,0ah,0ah,0ah,