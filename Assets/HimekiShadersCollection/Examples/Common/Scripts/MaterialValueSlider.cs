using UnityEngine;
using UnityEngine.UI;

public class MaterialValueSlider : MonoBehaviour
{
	public string propertyName;
	public float maxValue = 1f;
	public Text propertyNameText;
    public Slider valueSlider;
    public Text valueText;
    public Material material;

    void OnEnable()
    {
		propertyNameText.text = propertyName;

		valueSlider.maxValue = maxValue;
        valueSlider.value = material.GetFloat(propertyName);
        valueText.text = valueSlider.value.ToString();
    }
    public void onSliderValueChanged(float value)
    {
        material.SetFloat(propertyName, value);

        valueText.text = value.ToString();
    }
}


