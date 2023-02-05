"
I export bloc element to a file.
See my subclasses for different output formats

"
Class {
	#name : #BlFileExporter,
	#superclass : #BlExporter,
	#instVars : [
		'fileName'
	],
	#category : #'Bloc-Exporter'
}

{ #category : #private }
BlFileExporter >> askFileName [
	| d elementFileName |
	elementFileName := String
			streamContents: [ :s | 
				d := DateAndTime now.
				d printYMDOn: s.
				s nextPut: $_.
				d printHMSOn: s separatedBy: $-.
				s
					nextPut: $_;
					nextPutAll: self element class name;
					nextPut: $-;
					nextPutAll: self element hash asString;
					nextPut: $.;
					nextPutAll: self extension ].
	^ Smalltalk imageDirectory / elementFileName
]

{ #category : #'api - exporting' }
BlFileExporter >> extension [
	"Return a default file extension to be used during export"
	<return: #String>
	
	^ self subclassResponsibility
]

{ #category : #accessing }
BlFileExporter >> fileName [
	^ fileName ifNil: [ fileName := self askFileName ]
]

{ #category : #'api - configuration' }
BlFileExporter >> fileName: aString [
	fileName := aString
]
