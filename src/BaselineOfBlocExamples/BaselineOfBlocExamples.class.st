Class {
	#name : #BaselineOfBlocExamples,
	#superclass : #BaselineOf,
	#category : #BaselineOfBlocExamples
}

{ #category : #baseline }
BaselineOfBlocExamples >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec
			baseline: 'Bloc' with: [
				spec repository: 'github://feenkcom/Bloc:v0.8.255/src' ].
		spec
			baseline: 'Beacon' with: [
				spec repository: 'github://feenkcom/pharo-beacon:89477b28e468d10cb46d61a8c5b8d83ee0b2d592/repository' ].
		spec
			baseline: 'SpartaSkia' with: [
				spec repository: 'github://feenkcom/Sparta:v0.8.74/src' ].
		spec
			baseline: 'TaskIt' with: [
				spec repository: 'github://feenkcom/taskit:1c4cd1af9cd721b0b4a6d21aa6c6ac8fa86fe0f2' ].
		spec
			baseline: 'GToolkitExamplesEngine' with: [
				spec repository: 'github://feenkcom/gtoolkit-examples:v0.8.37/src' ].

		spec package: 'Bloc-Text-Examples' with: [
			spec requires: #('Bloc') ].
		spec package: 'Bloc-Layout-Examples' with: [
			spec requires: #('Bloc' 'GToolkitExamplesEngine') ].
		spec package: 'Bloc-Examples' with: [
			spec requires: #('Bloc') ].
		spec package: 'Bloc-Compositor-Examples' with: [
			spec requires: #('Bloc' #'Bloc-Examples') ].
		spec package: 'Bloc-Docs' with: [
			spec requires: #('Bloc') ].
	]
]
