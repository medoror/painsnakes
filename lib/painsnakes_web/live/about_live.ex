defmodule PainsnakesWeb.AboutLive do
  use PainsnakesWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="about-page max-w-3xl mx-auto p-6 bg-white shadow-md rounded-lg">
      <h2 class="text-3xl font-bold text-gray-800 mb-4">About PainSnakes</h2>
      <p class="text-lg text-gray-600 mb-6">Welcome to the world of PainSnakes! 🐍</p>

      <p class="text-gray-700 mb-4">You are currently on: <%= @current_path %></p>

      <h3 class="text-2xl font-semibold text-gray-800 mb-3">What Are PainSnakes?</h3>
      <p class="text-gray-700 mb-6">
        Imagine a snake made of sticky notes, each one representing a task delay or interruption.
        Every time a team member encounters a delay, they jot down the details on a sticky note
        and add it to the "end of the snake." Over time, this snake grows, revealing patterns of
        interruptions that might otherwise go unnoticed.
      </p>

      <h3 class="text-2xl font-semibold text-gray-800 mb-3">Why Use PainSnakes?</h3>
      <ul class="list-disc list-inside text-gray-700 mb-6">
        <li>
          <strong>Validating Real Issues:</strong>
          By documenting interruptions, teams can distinguish between real problems and perceived ones.
        </li>
        <li>
          <strong>Quantifying Impact:</strong>
          Each note quantifies the time lost, helping teams prioritize which issues to tackle first.
        </li>
        <li>
          <strong>Creating Transparency:</strong>
          Managers and team members alike can see the snake grow, making it easier to address the root causes of delays.
        </li>
        <li>
          <strong>Empowering Teams:</strong>
          By giving team members a voice, PainSnakes encourage proactive problem-solving.
        </li>
      </ul>

      <h3 class="text-2xl font-semibold text-gray-800 mb-3">How Do They Work?</h3>
      <ol class="list-decimal list-inside text-gray-700 mb-6">
        <li>
          <strong>Capture the Delay:</strong>
          When a task is delayed, write down the time lost, the affected task, the cause, and your initials on a sticky note.
        </li>
        <li>
          <strong>Add to the Snake:</strong> Place the note at the end of the snake on the wall.
        </li>
        <li>
          <strong>Review and Reflect:</strong>
          Regularly review the snake to identify patterns and prioritize issues for resolution.
        </li>
        <li>
          <strong>Solve and Shrink:</strong>
          Once an issue is resolved, remove the related notes and watch the snake shrink!
        </li>
      </ol>

      <h3 class="text-2xl font-semibold text-gray-800 mb-3">Join the PainSnake Movement</h3>
      <p class="text-gray-700 mb-4">
        PainSnakes are a simple yet effective way to bring transparency and focus to your team's workflow.
        So why not give it a try? Embrace the snake, and turn those interruptions into opportunities for improvement!
      </p>
      <p class="text-gray-700">
        For more insights and the story behind PainSnakes, check out the original <a
          href="http://agile-commentary.blogspot.com/2008/12/snake-on-wall.html"
          target="_blank"
          class="text-blue-500 hover:underline"
        >Agile Commentary post</a>.
      </p>
    </div>
    """
  end
end
