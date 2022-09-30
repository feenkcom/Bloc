Class {
	#name : #BlDevScripterKeyClickStep,
	#superclass : #BlDevScripterKeyboardStep,
	#category : #'Bloc-Scripter-Scripter-Steps'
}

{ #category : #accessing }
BlDevScripterKeyClickStep >> defaultLabel [
	^ self key
		ifNotNil: [ :aKey | 'Key press: {1}' format: {aKey name} ]
		ifNil: [ 'Key press' ]
]

{ #category : #actions }
BlDevScripterKeyClickStep >> playOn: aScripter [
	BlSpace simulateKeyDownOn: aScripter element key: self key.
	BlSpace simulateKeyUpOn: aScripter element key: self key.
	aScripter pulse
]
