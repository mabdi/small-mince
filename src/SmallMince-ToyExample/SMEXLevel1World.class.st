Class {
	#name : #SMEXLevel1World,
	#superclass : #SMEXWorld,
	#category : #'SmallMince-ToyExample'
}

{ #category : #'as yet unclassified' }
SMEXLevel1World class >> getMap [

	^ { 
		  #( 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ).
		  #( 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ).
		  #( 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ).
		  #( 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ).
		  #( 0 0 c c c m B B B 0 0 0 0 0 0 0 0 0 0 0 ).
		  #( 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ).
		  #( 0 0 0 0 0 0 0 0 0 0 0 0 0 P P 0 0 0 0 0 ).
		  #( 0 0 0 0 0 0 0 0 0 0 0 0 0 P P 0 0 0 0 0 ).
		  #( 0 0 0 0 0 0 0 0 0 0 0 0 0 P P 0 0 T 0 0 ).
		  #( G G G G G G G G G G G G G G G G G G G G ) }
]

{ #category : #accessing }
SMEXLevel1World class >> level [
	^ 1
]

{ #category : #initialization }
SMEXLevel1World >> setUp [

	| theObject |
	height := self class getMap size.
	width := self class getMap first size.
	self class getMap doWithIndex: [ :line :rowIdx | 
		line doWithIndex: [ :objId :colIdx | 
			theObject := SMEXObjects getById: objId asString.
			theObject ifNotNil: [ 
				theObject location: rowIdx @ colIdx.
				self add: theObject ] ] ]
]
