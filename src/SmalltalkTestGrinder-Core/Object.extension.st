Extension { #name : #Object }

{ #category : #'*SmalltalkTestGrinder-Core' }
Object >> tg_internal_class [
	^ false
]

{ #category : #'*SmalltalkTestGrinder-Core' }
Object >> tg_valueReference [
	^ TGSkippedValue with: self
]
