Class {
	#name : #BlSpaceTelemetry,
	#superclass : #Object,
	#traits : 'Telemetry',
	#classTraits : 'Telemetry classTrait',
	#instVars : [
		'space',
		'telemetry'
	],
	#category : #'Bloc-Telemetry'
}

{ #category : #'api - telemetry' }
BlSpaceTelemetry >> emitAs: aSourceTelemetry [
	"Space telemetry should emit the inner telemetry"
	telemetry emit
]

{ #category : #initialization }
BlSpaceTelemetry >> initialize [
	super initialize.
	
	telemetry := NullTelemetry uniqueInstance
]

{ #category : #'api - telemetry' }
BlSpaceTelemetry >> reset [
	telemetry reset
]

{ #category : #accessing }
BlSpaceTelemetry >> space [

	^ space
]

{ #category : #accessing }
BlSpaceTelemetry >> space: anObject [

	space := anObject
]

{ #category : #accessing }
BlSpaceTelemetry >> telemetry [

	^ telemetry
]

{ #category : #accessing }
BlSpaceTelemetry >> telemetry: anObject [

	telemetry := anObject
]

{ #category : #'api - telemetry' }
BlSpaceTelemetry >> time: aNameBlock during: aBlock [
	^ telemetry time: aNameBlock during: aBlock
]
