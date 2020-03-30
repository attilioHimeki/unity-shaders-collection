using UnityEngine;
using UnityEngine.UI;

public class MaterialValueSlider : MonoBehaviour
{
	public string propertyName;
    public Slider valueSlider;
    public Text valueText;
    public Material material;

    void OnEnable()
    {
        valueSlider.value = material.GetFloat(propertyName);

        valueText.text = valueSlider.value.ToString();
    }
    public void onSliderValueChanged(float value)
    {
        material.SetFloat(propertyName, value);

        valueText.text = value.ToString();
    }
}


