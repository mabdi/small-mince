Extension { #name : #String }

{ #category : #'*TestGrinder' }
String >> tg_valueReference [
	^ TGPrimitiveValue  with: self
]
