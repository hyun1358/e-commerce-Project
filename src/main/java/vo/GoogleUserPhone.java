package vo;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;


@JsonIgnoreProperties(ignoreUnknown = true)
public class GoogleUserPhone {

    private String resourceName;
    private String etag;
    private List<PhoneNumber> phoneNumbers;

    // getters & setters

    public String getResourceName() {
        return resourceName;
    }
    public void setResourceName(String resourceName) {
        this.resourceName = resourceName;
    }

    public String getEtag() {
        return etag;
    }
    public void setEtag(String etag) {
        this.etag = etag;
    }

    public List<PhoneNumber> getPhoneNumbers() {
        return phoneNumbers;
    }
    public void setPhoneNumbers(List<PhoneNumber> phoneNumbers) {
        this.phoneNumbers = phoneNumbers;
    }

    @JsonIgnoreProperties(ignoreUnknown = true)
    public static class PhoneNumber {
        private String value;
        private String canonicalForm;
        private String type;
        private String formattedType;

        // getters & setters
        public String getValue() {
            return value;
        }
        public void setValue(String value) {
            this.value = value;
        }

        public String getCanonicalForm() {
            return canonicalForm;
        }
        public void setCanonicalForm(String canonicalForm) {
            this.canonicalForm = canonicalForm;
        }

        public String getType() {
            return type;
        }
        public void setType(String type) {
            this.type = type;
        }

        public String getFormattedType() {
            return formattedType;
        }
        public void setFormattedType(String formattedType) {
            this.formattedType = formattedType;
        }
    }
}