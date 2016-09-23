MARY_VERSION=5.3-SNAPSHOT
MARY_BASE=/mary/marytts
VOICE_TOOLS=$(MARY_BASE)/target/marytts-builder-$(MARY_VERSION)/bin/voiceimport.sh
MARY_SERVER=$(MARY_BASE)/target/marytts-$(MARY_VERSION)/bin/marytts-server
ROOT_DIR=/mary/marytts-voice-building

all: AllophonesExtractor EHMMlabeler LabelPauseDeleter PhoneUnitLabelComputer TranscriptionAligner mary/features.txt PhoneUnitFeatureComputer PhonelabelFeatureAligner HMMVoiceDataPreparation HMMVoiceConfigure HMMVoiceFeatureSelection HMMVoiceMakeData HMMVoiceMakeVoice HMMVoiceCompiler

AllophonesExtractor: text/ wav/
	$(VOICE_TOOLS) AllophonesExtractor

EHMMlabeler: prompt_allophones/
	$(VOICE_TOOLS) EHMMLabeler

LabelPauseDeleter: ehmm/lab/
	$(VOICE_TOOLS) LabelPauseDeleter

PhoneUnitLabelComputer: lab/
	$(VOICE_TOOLS) PhoneUnitLabelComputer

TranscriptionAligner: phonelab/
	$(VOICE_TOOLS) TranscriptionAligner

FeatureSelection: allophones/
	$(VOICE_TOOLS) FeatureSelection

PhoneUnitFeatureComputer: mary/features.txt
	$(VOICE_TOOLS) PhoneUnitFeatureComputer

PhonelabelFeatureAligner: phonelab/ phonefeatures/
	$(VOICE_TOOLS) PhonelabelFeatureAligner

HMMVoiceDataPreparation: phonefeatures/ phonelab/ $(ROOT_DIR)/mary/features.txt $(MARY_BASE)/lib/external/externalBinaries.config
	$(VOICE_TOOLS) HMMVoiceDataPreparation

HMMVoiceFeatureSelection: $(ROOT_DIR)/mary/features.txt
	$(VOICE_TOOLS) HMMVoiceFeatureSelection

HMMVoiceMakeData: $(ROOT_DIR)/mary/hmmFeatures.txt $(ROOT_DIR)/hts/data/
	cd $(ROOT_DIR)/hts/data/

HMMVoiceMakeVoice: $(ROOT_DIR)/hts/data/
	cd $(ROOT_DIR)
	perl scripts/Training.pl scripts/Config.pm > make-voice.log

HMMVoiceCompiler: $(ROOT_DIR)/hts/data/
	$(VOICE_TOOLS) HMMVoiceCompiler
