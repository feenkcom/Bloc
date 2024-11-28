Extension { #name : #WideString }

{ #category : #'*Bloc' }
WideString >> gtCharIndexAtByteOffset: anOffset [
	<primitive: 'primitiveWideStringByteIndexToCharIndex'>
	
	^ self primitiveFail
]
