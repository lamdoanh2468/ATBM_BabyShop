package vn.edu.nlu.fit.be.util;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

public class JsonUtil {
    public static String get(String json, String key) {
        JsonObject obj = JsonParser.parseString(json).getAsJsonObject();
        return obj.has(key) ? obj.get(key).getAsString() : null;
    }
}
