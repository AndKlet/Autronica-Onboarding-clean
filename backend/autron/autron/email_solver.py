from django import forms


class AccessRequestForm(forms.Form):
    sender_email = forms.EmailField(label="Your Email", required=True)
    recipient_email = forms.EmailField(label="Recipient Email", required=True)
    message = forms.CharField(widget=forms.Textarea, label="Why do you need access?", required=True)
