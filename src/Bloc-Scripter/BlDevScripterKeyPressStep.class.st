Class {
	#name : #BlDevScripterKeyPressStep,
	#superclass : #BlDevScripterKeyboardStep,
	#category : #'Bloc-Scripter-Scripter-Steps'
}

{ #category : #accessing }
BlDevScripterKeyPressStep >> defaultLabel [
	^ self key
		ifNotNil: [ :aKey | 'Key press: {1}' format: {aKey name} ]
		ifNil: [ 'Key press' ]
]

{ #category : #actions }
BlDevScripterKeyPressStep >> playOn: aScripter [
	BlSpace simulateKeyDownOn: aScripter element key: self key.
	BlSpace simulateKeyUpOn: aScripter element key: self key.
	aScripter pulse
]
