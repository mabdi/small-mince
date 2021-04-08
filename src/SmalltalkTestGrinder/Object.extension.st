Extension { #name : #Object }

{ #category : #'*SmalltalkTestGrinder' }
Object >> tg_internal_class [
	^ false
]

{ #category : #'*SmalltalkTestGrinder' }
Object >> tg_valueReference [
	^ TGSkippedValue with: self
]
