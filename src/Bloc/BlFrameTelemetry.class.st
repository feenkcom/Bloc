Class {
	#name : #BlFrameTelemetry,
	#superclass : #BaseProcessTelemetry,
	#category : #'Bloc-Telemetry'
}

{ #category : #accessing }
BlFrameTelemetry class >> defaultTelemetryClass [
	^ BlSpaceTelemetry
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
