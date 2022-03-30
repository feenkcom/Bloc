Class {
	#name : #BlGlutinHost,
	#superclass : #BlWinitHost,
	#category : #'BlocHost-Glutin-Host'
}

{ #category : #testing }
BlGlutinHost class >> isSupported [
	^ Glutin isSupported and: [ Smalltalk vm isRunningInWorkerThread not ]
]

{ #category : #accessing }
BlGlutinHost class >> priority [
	^ 2
]
