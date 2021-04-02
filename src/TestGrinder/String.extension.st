Extension { #name : #String }

{ #category : #'*TestGrinder' }
String >> tg_state [
	^ TGPrimitiveValue  with: self
]
