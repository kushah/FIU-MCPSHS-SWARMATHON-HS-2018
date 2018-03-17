

;------------------------------------------------------------------------------------

 ;; COMPETITION SUBMISSION FILE

;------------------------------------------------------------------------------------

 ;; Elizabeth E. Esterly
 ;; elizabeth@cs.unm.edu
 ;; The University of New Mexico
 ;; Swarmathon 5: Competition
 ;; Version 1.0
 ;; Last Revision 01/13/2017

;------------------------------------------------------------------------------------

  ;;Mentor: Kumar Yogesh Shah
  ;;Team Members:
  ;;Adrian Benitez
  ;;Alexis Cruz
  ;;Amanda Evans
  ;;Carolyne Foster
  ;;Gabriel Quiroz
  ;;Jose Amador
  ;;Julian Lopez
  ;;Julian Rodriguez
  ;;Matthew Vervuurt
  ;;Oscar Sanchez
  ;;Ricardo Colom
  ;;Victor Motolese
  ;;Yasmin Gomez
  ;;High School: Miami Coral Park Senior High School
  
;------------------------------------------------------------------------------------ 
 
;------------------------------------------------------------------------------------
;::::::::::::::::::::!!!!!!!!!   REQUIRED CODE  !!!!!!!!!::::::::::::::::::::
;------------------------------------------------------------------------------------

;------------------------------------------------------------------------------------
 
 ;;Using The Bitmap Extension
 Extensions[Bitmap]

;------------------------------------------------------------------------------------

 ;;Breeding Linear Robots
 Breed [LinearRobots LinearRobot]

;------------------------------------------------------------------------------------
 
 ;;Telling The Patches What They Need To Know 
 Patches-Own [BaseColor]  

;------------------------------------------------------------------------------------

 ;;Telling The LinearRobots What They Need To Know 
 LinearRobots-Own 
  
  [
    
    ;;Will These Robots Use The List Of Rocks Stored?
    StoredList?
    
    ;;Will These Robots Be Going Back To Base?
    Returning?
    
    ;;Storage Of The X & Y Coordinates
    StoredLocations
    
    ;;Rock's X Coordinate
    XCoord
    
    ;;Rock's Y Coordinate
    YCoord
    
    ;;What Direction Will They Be Initially Facing?
    InitialDirection
       
  ]

;------------------------------------------------------------------------------------
 
;------------------------------------------------------------------------------------
;::::::::::::::::::::!!!!!!!!!   REQUIRED CODE  !!!!!!!!!::::::::::::::::::::
;------------------------------------------------------------------------------------

;------------------------------------------------------------------------------------

  ;;;;;;;;;;;;;;;;;;
  ;;    setup     ;; : MAIN PROCEDURE
  ;;;;;;;;;;;;;;;;;;

;------------------------------------------------------------------------------------

 ;;Writing The Setup Procedures 
 To Setup
   
   ;;Calling A Function At The End Of The Code For Setup
   File-Config
   
   ;;Calling To Create Our Linear Robots Here
   Make-LinearRobots
 
 ;;To End This Procedure  
 End

;------------------------------------------------------------------------------------
 
 ;;The Function To Create Our Linear Robots
 To Make-LinearRobots
   
   ;;Creating 6 Linear Robots, With The Following Features/Settings
   Create-LinearRobots 6 
   
   [
     
     ;;Setting Their Size To 5
     Set Size 5
     
     ;;Setting Their Initial Shape To A Robot
     Set Shape "Robot"
    
     ;;Setting Their Color To Cyan
     Set Color Cyan
     
     ;;Setting Their Returning Back To Base Feature Off
     Set Returning? False
    
     ;;Setting Their Current Location Coordinates Storage Off
     Set StoredList? False
    
     ;;Setting Their Current Location Coordinates Storage To Be Empty
     Set StoredLocations []
     
     ;;Setting Their Inital Location X Coordinate To Orgin X Coordinate
     Set XCoord 0
     
     ;;Setting Their Inital Location Y Coordinate To Orgin Y Coordinate
     Set YCoord 0
     
     ;;Setting Their Initial Direction From Home Base To A Random Angle Of 360 
     Set InitialDirection Random 360
    
     ;;Setting Their Heading Direction To The Initial Direction Set Above
     Set Heading InitialDirection
    
   ]
 
 ;;To End This Function 
 End

;------------------------------------------------------------------------------------
 
;------------------------------------------------------------------------------------
;::::::::::::::::::::!!!!!!!!!   REQUIRED CODE  !!!!!!!!!::::::::::::::::::::
;------------------------------------------------------------------------------------

;------------------------------------------------------------------------------------

  ;;;;;;;;;;;;;;;;;;;;;;;;;
  ;;    ROBOT CONTROL    ;; : MAIN PROCEDURE
  ;;;;;;;;;;;;;;;;;;;;;;;;;

;------------------------------------------------------------------------------------
 
 ;;Writng The Procedure To Control The Robots Autonomously
 To Robot-Control
  
   ;;Asking The Linear Robots To Do The Linear Function Set Below
   Ask LinearRobots [Linear]
   
   ;;Asking The Linear Robots To Do Draw A Colored Line Down Of It's Path
   Ask LinearRobots [Pen-Down]
   
   ;;Telling Each Movement Of Each Robot To Be A Tick
   Tick
   
   ;;Setting If The Ammount Of Moments (Ticks) Equals The Allowed Time, Stop Everything
   If Ticks = 3600 [Stop]
 
 ;;To End This Procedure   
 End

;------------------------------------------------------------------------------------

 ;;Writng The Function To Have The Robots Do A Linear Pattern
 To Linear
   
   ;;Initially Setting That If No Rocks Are Left, Stop
   If Count Patches With [PColor = Yellow] = 0 [Stop]
   
   ;;Asking The Linear Robots To Do The Following
   Ask LinearRobots
   [
     
     ;;If The Robot Got To The Edge Of The Map To Do The Following
     If Not Can-Move? 1 
     [
       
       ;;Do The Stated Below Linear Function
       DoLinear
       
       ;;Stating A Conditional Function For The Storage Of Encountered Rock Loctaions
       IfElse Not Empty? StoredLocations
       [
         
         ;;If The Stored List Of Rocks Is Not Empty, Then Set The Stored List Values Function On
         Set StoredList? True
       
       ]
       [      
       
         ;;If The Stored List Of Rocks Is Empty, Then Set The Returning To Home Base Function On
         Set Returning? True
         
       ]
      ]
    
    ;;If The Stored List Funtion Is Set On, As Well As, The Returning Function Is Set Off, Then Use The Stored List Function Below     
    If StoredList? And Not Returning? [StoredList]
    
    ;;If The Returning Function Is Set On, Then Use The Return To Home Base Function Below
    If Returning? [ReturnToBase]
    
    ;;If The Stored List Funtion Is Set Off, As Well As, The Returning Function Is Set Off, Then Do The Linear Function Below
    If Not StoredList? And Not Returning? [DoLinear]
    
    ]
 
 ;;To End This Function      
 End   

;------------------------------------------------------------------------------------
 
 ;;Writng The Function For The Stored List Fuction Called For Above
 To StoredList
   
   ;;Stating A Conditional Function For The Storage Of Encountered Rock Loctaions
   IfElse Not Empty? StoredLocations
   [

     ;;If The Stored List Of Rocks Is Not Empty And The X & Y Stored Coordinates are Equal To Zero, Then Do The Following Below
     If XCoord = 0 And YCoord = 0

     [

       ;;Do The Reset Coordinate Function Below
       ResetCoordinates

     ]

       ;;If The Stored List Of Rocks Is Not Empty And The X & Y Stored Coordinates are NOT Equal To Zero, Then Do The Moving Function Below
       MoveToLocationSet

     ]
     [

       ;;If The Stored List Of Rocks Is Empty, Then Set The Stored List Values Function Off
       Set StoredList? False

     ]

       ;;Making The Robot Move Forward In One Step At A Time
       Forward 1

 ;;To End This Function      
 End

;------------------------------------------------------------------------------------
 
 ;;Writng The Function For The Reset Coordinate Function Called For Above
 To ResetCoordinates
   
   ;;If The Stored List Of Rocks Is Not Empty, Then Do The Following
   If Not Empty? StoredLocations
   [
     
     ;;Let This New Variable Be The First Set Of Coordinates Of The Stored List Of Rocks
     Let Coord First StoredLocations
     
     ;;Stores The X Coordinate Obtained To The First Position In The New Variable Above 
     Set XCoord First Coord
     
     ;;Stores The Y Coordinate Obtained To The Last Position In The New Variable Above
     Set YCoord Last Coord     
     
     ;;Stores The Locations Of The New Rock Locations, Except The First Set Of Coordinates, Beacuse We Just Used Them Above
     Set StoredLocations But-First StoredLocations
     
   ]
 
 ;;To End This Function   
 End

;------------------------------------------------------------------------------------
 
 ;;Writng The Function For The Moving Fuction Called For Above
 To MoveToLocationSet
    
    ;;Stating A Conditional Function For The Storage Of Certain Rock Loctaions, When Both The X & Y Positions Equal The X & Y Coordinates Stored
    IfElse (PXCor = XCoord And PYCor = YCoord)
    [
    
      ;;If The Robot Is At The Rock Location, Then Change The Shape Of The Robot To Robot With Rock, Meaning It Picked Up the Rock
      Set Shape "Robot With Rock"
      
      ;;Asking The Built In Patch Function To Do The Following  
      Ask Patch-Here 
      [
    
        ;;Set The Patch Color To Home Base Color
        Set PColor BaseColor
        
      ]
      
      ;;Set The Returing Values Function On, For It To Return To Home Base
      Set Returning? True
      
    ]
    [
    
      ;;If The Robot Is NOT At The Rock Location, Then Face It And Continue To It
      FaceXY XCoord YCoord
      
    ]
 
 ;;To End This Function    
 End

;------------------------------------------------------------------------------------
 
 ;;Writng The Function For The Return To Home Base Fuction Called For Above
 To ReturnToBase
    
    ;;Stating A Conditional Function For The Location Of The Robot
    IfElse PXCor = 0 And PYCor = 0
    [
     
      ;;If The Robot Is At The Orgin, Home Base, Then Set The Robot's Shape Back To Robot, Which Is Robot Without Rock
      Set Shape "Robot"
      
      ;;Also, Set The Return To Home Base Function Off
      Set Returning? False
      
      ;;Also, Set The Robot's X Coordinate To Zero, That Of Home Base
      Set XCoord 0
      
      ;;Also, Set The Robot's Y Coordinate To Zero, That Of Home Base
      Set YCoord 0
     
     ;;If The Stored List Values Function Is Off, Then Do The Following
     If Not StoredList?
     [
       
       ;;Set The New Initial Direction To That It Is Initally Set Above, While Adding An Additional PI Degrees To It 
       Set  InitialDirection  InitialDirection + 3.141592658979323642
       
       ;;Set The Robot's Heading Direction To This New Updated Angle Value 
       Set Heading  InitialDirection
       
     ]
     ]
     [
       
       ;;If The Robot Is At The Orgin, Home Base, Then Face The Orgin
       FaceXY 0 0
       
     ]
     
     ;;Making The Robot Move Forward In One Step At A Time
     Forward 1
     
 ;;To End This Function     
 End

;------------------------------------------------------------------------------------
 
 ;;Writng The Function For The Doing Of The Linear Fuction Called For Above    
 To DoLinear
    
    ;;Asking The Built In Patch Function To Do The Following
    Ask Patch-Here
    [
      
      ;;If The Patch Color Equal The Rocks Color, Then Do The Following
      If PColor = Yellow
      [
       
        ;;Let This New Variable To Create A List Of X & Y Coordinates The Robot Is At
        Let Locations (List PXCor PYCor)
        
        ;;Asking The Robot To Do The Following
        Ask Myself
        [
          
          ;;Set The Values Obtained Into The Main Stored List Of Rocks, While Bringing That Set Of Coordinates To The Top Of The List, While Deleting Any Repeated Coordinates
          Set StoredLocations Remove-Duplicates (FPut Locations StoredLocations)
          
        ]
      ]
    ]
    
    ;;Making The Robot Move Forward In One Step At A Time
    Forward 1
 
 ;;To End This Function    
 End                   

;------------------------------------------------------------------------------------

;------------------------------------------------------------------------------------
;::::::::::::::::::::!!!!!!!!!   REQUIRED CODE  !!!!!!!!!::::::::::::::::::::
;------------------------------------------------------------------------------------

;------------------------------------------------------------------------------------

  ;;;;;;;;;;;;;;;;;;;;;;;
  ;;   File-Config     ;; 
  ;;;;;;;;;;;;;;;;;;;;;;;

;------------------------------------------------------------------------------------

 ;;Writng The Function To Configure The File As Called For Above
 To File-Config
  
  ;;Clears Entire Program 
  CA 
  
  ;;Clears All Patches 
  CP 
  
  ;;Imports The Parking Lot Background Map Into The Program
  Bitmap:Copy-To-PColors Bitmap:Import "parkingLot.jpg" True
  
  ;;Resets The Ticks To Zero 
  Reset-Ticks
  
  ;;Calls The Making Of Rocks Function Below
  Make-Rocks
  
  ;;Calls The Making Of Home Base Function Below
  Make-Base

 ;;To End This Function 
 End
 

;------------------------------------------------------------------------------------

 ;;Writng The Function To Make Rocks
 To Make-Rocks
   
   ;;Asking The Patches To Do The Following
   Ask Patches [Set BaseColor PColor]
   
   ;;If Statement To Create A Random Cross Pattern Of Rocks
   If Distribution = "cross" Or Distribution = "random + cross" Or Distribution = "large clusters + cross"
   Or Distribution = "clusters + cross" Or Distribution = "random + clusters + cross" 
   Or Distribution = "random + clusters + large clusters + cross"[Make-Cross]
   
   ;;If Statement To Create A Random Pattern Of Rocks
   If Distribution = "random" Or Distribution = "random + cross" Or Distribution = "random + clusters"
   Or Distribution = "random + large clusters" Or Distribution = "random + clusters + cross" 
   Or Distribution = "random + clusters + large clusters + cross" [Make-Random]
   
   ;;If Statement To Create A Random Pattern Of Clustered Rocks
   If Distribution = "clusters" Or Distribution = "clusters + cross" Or Distribution = "random + clusters"
   Or Distribution = "clusters + large clusters" Or Distribution = "random + clusters + cross" 
   Or Distribution = "random + clusters + large clusters + cross" [Make-Clusters]
   
   ;;If Statement To Create A Random Pattern Of Large Clustered Rocks
   If Distribution = "large clusters" Or Distribution = "large clusters + cross"
   Or Distribution = "random + large clusters"  Or Distribution = "clusters + large clusters" 
   Or Distribution = "random + clusters + large clusters + cross" [Make-Large-Clusters]
  
 ;;To End This Function   
 End

;------------------------------------------------------------------------------------

 ;;Writng The Function To Make A Cross Patteren Of Rocks
 To Make-Cross
   
   ;;Asking The Patches To Do The Following
   Ask Patches 
   [
  
     ;;Let This New Variable Be The Max Patch X Coordinate Times Two
     Let DoubleMax Max-PXCor * 2 
     
     ;;If The Remainder Of The Patch X Coordinate Equal The New Variable Above Which Equals To Zero OR
     ;;The Remainder Of The Patch Y Coordinate Equal The New Variable Above Which Equals To Zero, Then
     ;;Set The Patch Color To Yellow, To Represent Rocks  
     If PXCor Mod DoubleMax = 0 Or PYCor Mod DoubleMax = 0 [Set PColor Yellow]  
     
   ]                   
 
 ;;To End This Function 
 End

;------------------------------------------------------------------------------------

 ;;Writng The Function To Make Random Single Rocks
 To Make-Random
  
   ;;Allow The Variable For Targeted Patches To Be The Variable Of Single Rocks Itself 
   Let TargetPatches SingleRocks
   
      ;;A Conditional Statement, While The Amount Of Patches Of Rocks Is Greater Than Zero, Then Do The Following 
     While [TargetPatches > 0]
     [
       
       ;;Asking One Of The Patches To Do The Following
       Ask One-Of Patches
       [
         
         ;;If The Patch Color Is NOT Yellow, Then Do The Following
         If PColor != Yellow
         [
           
           ;;Set The Patch Color To Yellow, To Represent Rocks
           Set PColor Yellow
           
           ;;Set The Patches To Itself Minus 1
           Set TargetPatches TargetPatches - 1
           
         ]
       ]
     ]
 
 ;;To End This Function 
 End

;------------------------------------------------------------------------------------

 ;;Writng The Function To Make The Clusters Of Rocks
 To Make-Clusters
   
   ;;Allow The Variable For Targeted Clusters To Be The Variable Of Clusters Itself 
   Let TargetClusters ClusterRocks
    
    ;;A Conditional Statement, While The Amount Of Clusters Of Rocks Is Greater Than Zero, Then Do The Following  
    While [TargetClusters > 0]
    [
      
      ;;Asking One Of The Patches To Do The Following
      Ask One-Of Patches
      [
        
        ;;If The Patch Color Is NOT Yellow, The Color Of Rocks, And The Neighboring Patches In The Radius Of Four Of It Is NOT Yellow, As Well, Then Do The Following
        If PColor != Yellow And [PColor] Of Neighbors4 != Yellow
        [
          
          ;;Set The Patch Color To Yellow, To Represent Rocks
          Set PColor Yellow
          
          ;;Asking The Neighboring Patches In A Radius Of Four To Turn To The Color Of Rocks, Yellow
          Ask Neighbors4 [Set PColor Yellow]
          
          ;;Set The Clusters To Itself Minus 1
          Set TargetClusters TargetClusters - 1
           
         ]
       ]
     ]

 ;;To End This Function 
 End

;------------------------------------------------------------------------------------

 ;;Writng The Function To Make The Large Clusters Of Rocks
 To Make-Large-Clusters
   
   ;;Allow The Variable For Targeted Large Clusters To Be The Variable Of Large Clusters Itself 
   Let TargetLargeClusters LargeClusterRocks
    
    ;;A Conditional Statement, While The Amount Of Large Clusters Of Rocks Is Greater Than Zero, Then Do The Following 
    While [TargetLargeClusters > 0]
    [
      
      ;;Asking One Of The Patches To Do The Following
      Ask One-Of Patches
      [
        
        ;;If The Patch Color Is NOT Yellow, The Color Of Rocks, And The Patches In The Radius Of Three Of It Is NOT Yellow, As Well, Then Do The Following
        If PColor != Yellow And [PColor] Of Patches In-Radius 3 != Yellow
        [
         
          ;;Set The Patch Color To Yellow, To Represent Rocks
          Set PColor Yellow
          
          ;;Asking The Patches In A Radius Of Three To Turn To The Color Of Rocks, Yellow
          Ask Patches In-Radius 3 [Set PColor Yellow]
          
          ;;Set The Large Clusters To Itself Minus 1
          Set TargetLargeClusters TargetLargeClusters - 1
          
        ]
       ]
     ]

 ;;To End This Function 
 End

;------------------------------------------------------------------------------------

 ;;Writng The Function To Make Home Base
 To Make-Base
  
  ;;Asking The Built In Patch Function To Do The Following 
  Ask Patches
   [
     
     ;;If At The Orgin, Make That Patch Green To Represent The Home Base
     If DistanceXY 0 0 = 0 [Set PColor Green]
     
   ]

 ;;To End This Function 
 End

;------------------------------------------------------------------------------------
@#$#@#$#@
GRAPHICS-WINDOW
235
13
750
549
50
50
5.0
1
10
1
1
1
0
0
0
1
-50
50
-50
50
0
0
1
ticks
5.0

BUTTON
14
10
81
44
setup
setup
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
111
11
229
45
robot-control
robot-control
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

MONITOR
66
200
180
245
rocks remaining
count patches with [pcolor = yellow]
17
1
11

CHOOSER
13
47
230
92
distribution
distribution
"cross" "random" "clusters" "large clusters" "random + cross" "clusters + cross" "clusters + large clusters" "large clusters + cross" "random + clusters" "random + large clusters" "random + clusters + cross" "random + clusters + large clusters + cross"
11

SLIDER
34
95
206
128
singleRocks
singleRocks
0
100
45
5
1
NIL
HORIZONTAL

SLIDER
34
130
206
163
clusterRocks
clusterRocks
0
50
20
5
1
NIL
HORIZONTAL

SLIDER
34
165
206
198
largeClusterRocks
largeClusterRocks
0
20
6
1
1
NIL
HORIZONTAL

@#$#@#$#@
## WHAT IS IT?

(a general understanding of what the model is trying to show or explain)

## HOW IT WORKS

(what rules the agents use to create the overall behavior of the model)

## HOW TO USE IT

(how to use the model, including a description of each of the items in the Interface tab)

## THINGS TO NOTICE

(suggested things for the user to notice while running the model)

## THINGS TO TRY

(suggested things for the user to try to do (move sliders, switches, etc.) with the model)

## EXTENDING THE MODEL

(suggested things to add or change in the Code tab to make the model more complicated, detailed, accurate, etc.)

## NETLOGO FEATURES

(interesting or unusual features of NetLogo that the model uses, particularly in the Code tab; or where workarounds were needed for missing features)

## RELATED MODELS

(models in the NetLogo Models Library and elsewhere which are of related interest)

## CREDITS AND REFERENCES

(a reference to the model's URL on the web if it has one, as well as any other necessary credits, citations, and links)
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

robot
true
1
Polygon -16777216 true false 75 60 105 15 135 15 90 75 75 60
Polygon -16777216 true false 225 60 195 15 165 15 210 75 225 60
Rectangle -16777216 true false 30 105 75 165
Rectangle -16777216 true false 30 210 75 270
Rectangle -16777216 true false 75 120 225 255
Rectangle -16777216 true false 225 210 270 270
Rectangle -16777216 true false 225 105 270 165
Rectangle -16777216 true false 90 120 210 195
Rectangle -2674135 true true 120 120 180 240
Rectangle -16777216 true false 195 225 210 240
Rectangle -16777216 true false 120 60 180 90
Rectangle -16777216 true false 135 90 165 120
Polygon -2674135 true true 180 75 210 90 210 105 180 90 180 75
Polygon -2674135 true true 120 75 90 90 90 105 120 90 120 75
Rectangle -7500403 true false 75 105 225 120
Line -2674135 true 90 120 90 240
Line -2674135 true 210 120 210 240
Line -2674135 true 135 90 165 90
Line -16777216 false 75 165 225 165
Line -16777216 false 75 180 225 180
Rectangle -7500403 true false 75 240 225 255

robot with rock
true
1
Rectangle -1184463 true false 120 0 180 45
Polygon -16777216 true false 75 60 105 15 135 15 90 75 75 60
Polygon -16777216 true false 225 60 195 15 165 15 210 75 225 60
Rectangle -16777216 true false 30 105 75 165
Rectangle -16777216 true false 30 210 75 270
Rectangle -16777216 true false 75 120 225 255
Rectangle -16777216 true false 225 210 270 270
Rectangle -16777216 true false 225 105 270 165
Rectangle -16777216 true false 90 120 210 195
Rectangle -2674135 true true 120 120 180 240
Rectangle -16777216 true false 120 60 180 90
Rectangle -16777216 true false 135 90 165 120
Polygon -2674135 true true 180 75 210 90 210 105 180 90 180 75
Polygon -2674135 true true 120 75 90 90 90 105 120 90 120 75
Rectangle -7500403 true false 75 105 225 120
Line -2674135 true 75 240 225 240
Line -2674135 true 90 120 90 240
Line -2674135 true 210 120 210 240
Line -2674135 true 135 90 165 90
Line -16777216 false 75 165 225 165
Line -16777216 false 75 180 225 180
Rectangle -7500403 true false 75 240 225 255

sheep
false
15
Circle -1 true true 203 65 88
Circle -1 true true 70 65 162
Circle -1 true true 150 105 120
Polygon -7500403 true false 218 120 240 165 255 165 278 120
Circle -7500403 true false 214 72 67
Rectangle -1 true true 164 223 179 298
Polygon -1 true true 45 285 30 285 30 240 15 195 45 210
Circle -1 true true 3 83 150
Rectangle -1 true true 65 221 80 296
Polygon -1 true true 195 285 210 285 210 240 240 210 195 210
Polygon -7500403 true false 276 85 285 105 302 99 294 83
Polygon -7500403 true false 219 85 210 105 193 99 201 83

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

wolf
false
0
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -7500403 true true 2 194 13 197 30 191 38 193 38 205 20 226 20 257 27 265 38 266 40 260 31 253 31 230 60 206 68 198 75 209 66 228 65 243 82 261 84 268 100 267 103 261 77 239 79 231 100 207 98 196 119 201 143 202 160 195 166 210 172 213 173 238 167 251 160 248 154 265 169 264 178 247 186 240 198 260 200 271 217 271 219 262 207 258 195 230 192 198 210 184 227 164 242 144 259 145 284 151 277 141 293 140 299 134 297 127 273 119 270 105
Polygon -7500403 true true -1 195 14 180 36 166 40 153 53 140 82 131 134 133 159 126 188 115 227 108 236 102 238 98 268 86 269 92 281 87 269 103 269 113

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270

@#$#@#$#@
NetLogo 5.2.0
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180

@#$#@#$#@
0
@#$#@#$#@
