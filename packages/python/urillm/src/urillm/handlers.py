from __future__ import annotations

from typing import Any

from .common import mock_result, var


def vision_analyze(payload: dict[str, Any], context: dict[str, Any]) -> dict[str, Any]:
    goal = str(payload.get("goal") or payload.get("instruction") or "").strip()
    target = str(payload.get("target_text") or "OK")
    return mock_result(
        "llm.vision.analyze",
        context,
        action="click",
        target_text=target,
        x=100,
        y=200,
        confidence=0.5,
        source="mock",
        goal=goal,
    )


def text_plan(payload: dict[str, Any], context: dict[str, Any]) -> dict[str, Any]:
    transcript = str(payload.get("transcript") or payload.get("text") or "").strip()
    return mock_result(
        "llm.text.plan",
        context,
        uri="him://local/keyboard/command/type",
        payload={"text": transcript[:1] or " "},
        transcript=transcript,
        model="mock",
    )


def text_decide(payload: dict[str, Any], context: dict[str, Any]) -> dict[str, Any]:
    question = str(payload.get("question") or "")
    ctx = payload.get("context") or {}
    retry = "error" in str(ctx).lower()
    return mock_result(
        "llm.text.decide",
        context,
        ok=retry,
        decision="retry" if retry else "abort",
        reason="mock-decide",
        confidence=0.8,
        model="mock",
        question=question,
    )


def chat_completion(payload: dict[str, Any], context: dict[str, Any]) -> dict[str, Any]:
    messages = payload.get("messages") or []
    prompt = payload.get("prompt") or (
        messages[-1].get("content") if messages and isinstance(messages[-1], dict) else ""
    )
    return mock_result(
        "llm.chat.completion",
        context,
        provider=var(context, "provider", "mock"),
        model=payload.get("model", "mock-model"),
        content=f"Mock completion for: {prompt}",
        format=payload.get("format", "text"),
    )
