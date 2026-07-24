Class {
	#name : #BlFrameTelemetry,
	#superclass : #BaseProcessTelemetry,
	#category : #'Bloc-Telemetry'
}

{ #category : #accessing }
BlFrameTelemetry class >> defaultTelemetryClass [
	^ BlSpaceTelemetry
]

{ #category : #'as yet unclassified' }
BlFrameTelemetry class >> primitiveTelemetryComputationSignal: isStart object: anObject process: aProcess [
	<primitive: 'primitiveTelemetryObjectSignal'>
]

{ #category : #'as yet unclassified' }
BlFrameTelemetry class >> primitiveTelemetryContextSignal: anObject process: aProcess [
	<primitive: 'primitiveTelemetryContextSignal'>
]

{ #category : #'as yet unclassified' }
BlFrameTelemetry class >> telemetryComputationEndSignal: anObject [
	self
		primitiveTelemetryComputationSignal: false
		object: anObject
		process: Processor activeProcess
]

{ #category : #'as yet unclassified' }
BlFrameTelemetry class >> telemetryComputationStartSignal: anObject [
	self
		primitiveTelemetryComputationSignal: true
		object: anObject
		process: Processor activeProcess
]

{ #category : #'as yet unclassified' }
BlFrameTelemetry class >> telemetryContextSignal: anObject [
	self
		primitiveTelemetryContextSignal: anObject
		process: Processor activeProcess
]

{ #category : #accessing }
BlFrameTelemetry class >> withSpace: aBlSpace andTelemetry: aBlTelemetry do: aBlock [
	self soleInstance ensureValue
		telemetry: aBlTelemetry;
		space: aBlSpace.

	aBlock ensure: [
		self soleInstance ensureValue
			telemetry: NullTelemetry uniqueInstance;
			space: nil ]
]

{ #category : #accessing }
BlFrameTelemetry >> space [
	^ self value space
]

{ #category : #accessing }
BlFrameTelemetry >> space: aBlSpace [
	self value space: aBlSpace
]

{ #category : #accessing }
BlFrameTelemetry >> telemetry [
	^ self value telemetry
]

{ #category : #accessing }
BlFrameTelemetry >> telemetry: aBlTelemetry [
	self value telemetry: aBlTelemetry
]
