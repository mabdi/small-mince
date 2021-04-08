Extension { #name : #Boolean }

{ #category : #'*SmalltalkTestGrinder-Core' }
Boolean >> tg_valueReference [
	^ TGPrimitiveValue  with: self
]
