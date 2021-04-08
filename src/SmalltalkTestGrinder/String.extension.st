Extension { #name : #String }

{ #category : #'*SmalltalkTestGrinder' }
String >> tg_valueReference [
	^ TGPrimitiveValue  with: self
]
