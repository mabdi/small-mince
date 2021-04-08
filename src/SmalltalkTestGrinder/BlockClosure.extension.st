Extension { #name : #BlockClosure }

{ #category : #'*SmalltalkTestGrinder' }
BlockClosure >> tg_valueReference [
	^ TGBlockValue  with: self
]
