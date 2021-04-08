Extension { #name : #BlockClosure }

{ #category : #'*SmalltalkTestGrinder-Core' }
BlockClosure >> tg_valueReference [
	^ TGBlockValue  with: self
]
