Class {
	#name : #SMClassX,
	#superclass : #Object,
	#instVars : [
		'last'
	],
	#category : #'SmallMince-Tests'
}

{ #category : #'as yet unclassified' }
SMClassX >> mx1 [

	last := #mx1
]

{ #category : #'as yet unclassified' }
SMClassX >> mx2Y: yObj [

	| z |
	last := #mx2.
	z := SMClassZ new.
	z mz1.
	yObj my1Z: z.
	^ 1
]
