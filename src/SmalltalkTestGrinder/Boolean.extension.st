Extension { #name : #Boolean }

{ #category : #'*SmalltalkTestGrinder' }
Boolean >> tg_valueReference [
	^ TGPrimitiveValue  with: self
]
