Extension { #name : #Object }

{ #category : #'*TestGrinder' }
Object >> tg_internal_class [
	^ false
]

{ #category : #'*TestGrinder' }
Object >> tg_valueReference [
	^ TGSkippedValue with: self
]
