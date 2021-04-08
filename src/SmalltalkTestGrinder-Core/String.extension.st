Extension { #name : #String }

{ #category : #'*SmalltalkTestGrinder-Core' }
String >> tg_valueReference [
	^ TGPrimitiveValue  with: self
]
