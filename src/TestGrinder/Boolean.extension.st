Extension { #name : #Boolean }

{ #category : #'*TestGrinder' }
Boolean >> tg_valueReference [
	^ TGPrimitiveValue  with: self
]
