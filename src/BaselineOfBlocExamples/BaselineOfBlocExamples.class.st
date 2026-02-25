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
				spec repository: 'github://feenkcom/Bloc:v0.9.35/src' ].
		spec
			baseline: 'Beacon' with: [
				spec repository: 'github://feenkcom/pharo-beacon:eec65a4cce3f41371a5177aa18857b73ca4de247/repository' ].
		spec
			baseline: 'SpartaSkia' with: [
				spec repository: 'github://feenkcom/Sparta:v0.8.233/src' ].
		spec
			baseline: 'GToolkitExamplesEngine' with: [
				spec repository: 'github://feenkcom/gtoolkit-examples:v0.8.128/src' ].

		spec package: 'Bloc-Text-Examples' with: [
			spec requires: #(#Bloc) ].
		spec package: 'Bloc-Layout-Examples' with: [
			spec requires: #(#Bloc #GToolkitExamplesEngine) ].
		spec package: 'Bloc-Examples' with: [
			spec requires: #(#Bloc) ].
		spec package: 'Bloc-Compositor-Examples' with: [
			spec requires: #(#Bloc #'Bloc-Examples') ].
		spec package: 'Bloc-Docs' with: [
			spec requires: #(#Bloc) ].
	]
]
