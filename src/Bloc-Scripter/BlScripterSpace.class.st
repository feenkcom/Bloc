Class {
	#name : #BlScripterSpace,
	#superclass : #BlSpace,
	#category : #'Bloc-Scripter-Scripter-Utilities'
}

{ #category : #initialization }
BlScripterSpace >> defaultHost [
	^ BlMockedHost new
]

{ #category : #testing }
BlScripterSpace >> isOpened [
	"We consider a scripter space to be always opened"

	^ host isNotNil
]
