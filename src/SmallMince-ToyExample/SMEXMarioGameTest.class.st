Class {
	#name : #SMEXMarioGameTest,
	#superclass : #TestCase,
	#category : #'SmallMince-ToyExample'
}

{ #category : #tests }
SMEXMarioGameTest >> testGravity [

	| game |
	game := SMEXMarioGame level: 1.
	game player: #mario.
	game player location: 6 @ 5.
	game draw.
	self assert: game screen equals: '                    
                    
                    
                    
  ????===           
    *               
             ||     
             ||     
             ||  X  
____________________
'.
	game gravityPlayer.
	self assert: game player location equals: 9 @ 5.
	game draw.
	self assert: game screen equals: '                    
                    
                    
                    
  ????===           
                    
             ||     
             ||     
    *        ||  X  
____________________
'
]

{ #category : #tests }
SMEXMarioGameTest >> testRuns [

	| game |
	game := SMEXMarioGame level: 1.
	game player: #mario.
	game gameTick.
	self assert: game actionsBufferIsEmpty.
	self assert: game screen equals: '                    
                    
                    
                    
  ????===           
                    
             ||     
             ||     
 *           ||  X  
____________________
'.
	game acceptAction: #Right.
	game gameTick.
	self assert: game actionsBufferIsEmpty.
	self assert: game screen equals: '                    
                    
                    
                    
  ????===           
                    
             ||     
             ||     
  *          ||  X  
____________________
'.
	game acceptAction: #Right.
	game gameTick.
	self assert: game actionsBufferIsEmpty.
	self assert: game screen equals: '                    
                    
                    
                    
  ????===           
                    
             ||     
             ||     
   *         ||  X  
____________________
'.
	game acceptAction: #Right.
	game gameTick.
	self assert: game actionsBufferIsEmpty.
	self assert: game screen equals: '                    
                    
                    
                    
  ????===           
                    
             ||     
             ||     
    *        ||  X  
____________________
'.
	game acceptAction: #Jump.
	game gameTick.
	self assert: game actionsBufferIsEmpty.
	self assert: game screen equals: '                    
                    
                    
                    
  ??!?===           
    *               
             ||     
             ||     
             ||  X  
____________________
'.
	self assert: game player score equals: 1.
	game gameTick.
	self assert: game actionsBufferIsEmpty.
	self assert: game screen equals: '                    
                    
                    
                    
  ??!?===           
                    
             ||     
             ||     
    *        ||  X  
____________________
'.
	game gameTick.
	game acceptAction: #Right.
	game gameTick.
	self assert: game actionsBufferIsEmpty.
	self assert: game screen equals: '                    
                    
                    
                    
  ??!?===           
                    
             ||     
             ||     
     *       ||  X  
____________________
'.
	game acceptAction: #Jump.
	game gameTick.
	self assert: game actionsBufferIsEmpty.
	self assert: game screen equals: '                    
                    
                    
     @              
  ??!!===           
     *              
             ||     
             ||     
             ||  X  
____________________
'.
	game acceptAction: #Right.
	game gameTick.
	self assert: game actionsBufferIsEmpty.
	self assert: game screen equals: '                    
                    
                    
     @              
  ??!!===           
                    
             ||     
             ||     
      *      ||  X  
____________________
'.
	game acceptAction: #Jump.
	game gameTick.
	self assert: game actionsBufferIsEmpty.
	self assert: game screen equals: '                    
                    
                    
     @              
  ??!! ==           
      *             
             ||     
             ||     
             ||  X  
____________________
'
]
